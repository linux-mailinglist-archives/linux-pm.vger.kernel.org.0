Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818851D0095
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgELVR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 17:17:58 -0400
Received: from cmta20.telus.net ([209.171.16.93]:47457 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELVR6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 17:17:58 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id YcHhjiM2GdVYHYcHjjVzld; Tue, 12 May 2020 15:17:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1589318277; bh=lCmzouqvDwIKKyuHxG+JEEnygxM8jtT+WS6QXdOjx60=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=LN8jWasS+k5TKHoZ6BLNsncm08MI5JNgW8TDDJhPdZtJC0AAt6kkEoPqPGY9xxT7L
         OkGmcTbLKlbogdefDJX+tQjN5NUOevaSR53QQH6sfgyeVwrgTbHMiScDlLRP8EmPtu
         3MeewAbJ4+V0fdx8KI0A402fmlyFyvqhRu4TxugsjFWCmHFaToO0BNnAU9OxcaVdWW
         Zq4Xv1TxkWEzTBOpKqFzzSenuF1LFqORJ+v9WATH7R4CUGKphnyHfE2If2lxsU3D3y
         oKiCAf/ijockjQXlXP9TUw0J+HrxpXH7RRX7m2bmp6e9K+M7Kcz4Sb9Zf5iV3cRUBM
         uPBGqDVIKNA4w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Y5CGTSWN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=aatUQebYAAAA:8
 a=H9R6TWYQEZhs2jsBW84A:9 a=CjuIK1q_8ugA:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Hanjun Guo'" <guohanjun@huawei.com>
Cc:     <linux-pm@vger.kernel.org>, "'Jonathan Corbet'" <corbet@lwn.net>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
Subject: RE: [RFC v2 PATCH 0/6] cpuidle: Make cpuidle governor switchable to be the default behaviour
Date:   Tue, 12 May 2020 14:17:52 -0700
Message-ID: <000b01d628a2$ce0a1ab0$6a1e5010$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYey9jjgudlnXFSR52mQgNF139jGQJ1fYfA
X-CMAE-Envelope: MS4wfKqmccL6Yr81rmbZ/foisTd8sHzHQHT8UN7LmHAjmDhBOOw3sQHQQGiRnNsRsYskcaToVnGflCtKr3ZJKGc7OEBsJdkrOU3NVMMuNp+qtxRMhWjOgI5Q
 JjaTk4d44GKZf9frWXbbsNZEGJWZpfNfp5pw26k/Yf5zTtLubaCackp/tkyCY33DjI80oKy1dzFuug+PjkRs8joy/vbTCDLXBdI117Mqal7CIhDXKjWEIME3
 IUTEEgQPlAbwsC1R9QxUoALlIJBJZjEzbhZDLNzPxEHWX1Dw1v5YrzWx9eTJMxQf
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.04.30 01:40 Hanjun Guo wrote:

> For now cpuidle governor can be switched via sysfs only when the
> boot option "cpuidle_sysfs_switch" is passed, but it's important
>to switch the governor to adapt to different workloads, especially
> after TEO and haltpoll governor were introduced.
>
> Make cpuidle governor switchable to be the default behaviour by removing
> the sysfs_switch and switch attributes, also update the document as well.
>
> v1->v2:
> - Add two bugfix patch which can be triggered if the governor name is 15
>   characters, it is not a 'real' bug for now as we don't have such usecases
>   so we can merge them together via this patchset.
> - Remove the sysfs_switch, not introduce a CONFIG option to make cpuidle
>   governor switchable in default, suggested by Daniel.
> - Update the document after cpuidle_sysfs_switch is removed, suggested by
>   Doug Smythies.
>
> Hanjun Guo (6):
>  cpuidle: sysfs: Fix the overlap for showing available governors
>  cpuidle: sysfs: Accept governor name with 15 characters
>  cpuidle: Make cpuidle governor switchable to be the default behaviour
>  cpuidle: sysfs: Remove sysfs_switch and switch attributes
>  Documentation: cpuidle: update the document
>  Documentation: ABI: make current_governer_ro as a candidate for
>    removal
>
> Documentation/ABI/obsolete/sysfs-cpuidle           |  9 ++++
> Documentation/ABI/testing/sysfs-devices-system-cpu | 24 ++++------
> Documentation/admin-guide/pm/cpuidle.rst           | 20 ++++----
> Documentation/driver-api/pm/cpuidle.rst            |  5 +-
> drivers/cpuidle/sysfs.c                            | 56 ++++++----------------
> 5 files changed, 44 insertions(+), 70 deletions(-)
> create mode 100644 Documentation/ABI/obsolete/sysfs-cpuidle

Thanks,

Reviewed and tested by Doug Smythies <dsmythies@telus.net>
  

