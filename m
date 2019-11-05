Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC471F0640
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 20:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfKETue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 14:50:34 -0500
Received: from cmta20.telus.net ([209.171.16.93]:51694 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKETue (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 14:50:34 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id S4qTikm1RN5I9S4qUiD06M; Tue, 05 Nov 2019 12:50:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572983432; bh=bYXAmzYbAE76w3pwo75jUVoYPYdM1JNj8L4jjKrajwc=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=k8M9rUQpGu+4nvbaO0Ad0u2oD6ZnYcGssbdFIptmLFbd6R8a48rmIh3VnRLoXdoiR
         PpqqFHGQt556+FkRAVzJdwlt8A+UEJZOZ5uZFrJwjoxlNpkNrBK42vBuEkqsucDplT
         HRXDJJCXfNp/Ve1AlIB4RIaQ2vnyEmDrEERt8q9VoZUd29fLpGbdQSMe/0eEG6IVzG
         7ABQW/JZeE+AbuD5GADyVtzZHvuWTkr3Wmt0X3OqXPZixB78ntYsXyfPekTgYgQkOG
         AR+MQWpVdNPRSSkvFW7YQuOUKJxqNrTXUlDUSgDxyAhZTLD4iZA5d8HNxCSrg+II3O
         koti+VBQtk1zA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=pHJ4mSlp1tcR-IUNR54A:9
 a=CjuIK1q_8ugA:10 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
References: <60416800.X4hXmAfbqi@kreacher> <6803360.ubpITS43T2@kreacher>
In-Reply-To: <6803360.ubpITS43T2@kreacher>
Subject: RE: [PATCH 1/4] cpuidle: teo: Ignore disabled idle states that are too deep
Date:   Tue, 5 Nov 2019 11:50:27 -0800
Message-ID: <001401d59412$472aff20$d580fd60$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdV/snpL59nmqVU2TeuSwZUUEol+5QUXRYJw
X-CMAE-Envelope: MS4wfMzRFaIxFxospJKRKgrDH/SkH2NjZ9xU1YVNTBr4Peo3MVYCslw+kL0bdUvoC2BsOj30AxvZMfum0+Oc8ClP6oVQ0jcglOfgcjOXKCQEjb7NnYSnyzm+
 ATI1gI9d5cla8fC5C3s3/vIzGxLJf963JEN8j0Q0oWsrp8CxIjCqii6iUCbG7d3eGxm6exN89IRutqEZITnZBQawUxlut4zfZI5kyyFS4OK8L6Wz5n6vjByE
 5rfaj1aFEWGCqWo5OecsIyDuqcPLfraBOxy226Lth4UrGt7QgWps8IO2MjfS8tO0BuGLF7395WXvoc153PJ3Ocs8Fc61IJXA+78a0v2aijeVCzUj7zFZuTxA
 M7UVG4oJ
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.10 14:32 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Prevent disabled CPU idle state with target residencies beyond the
> anticipated idle duration from being taken into account by the TEO
> governor.
> 
> Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Doug Smythies <dsmythies@telus.net>


