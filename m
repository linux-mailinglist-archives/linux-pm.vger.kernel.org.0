Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD5871B4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405353AbfHIFsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 01:48:08 -0400
Received: from cmta19.telus.net ([209.171.16.92]:37698 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfHIFsH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 01:48:07 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id vxkxhj2oCeRl4vxkzhGzqZ; Thu, 08 Aug 2019 23:48:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1565329686; bh=g2gTzFC4G+ftse5loP4iwGkez7MZ+RNpw9w4IkSd6M4=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=ztpno6V+F+A+72BoqukRLXSOyncnJpVTxZOLXyXRWxxp3i7TjavD7o1WDSV65P4FV
         VHcJYG2E5zRdjFqQsGgBL0Vqh9bKpav0MBA0Xlv7Ca90dFx5Lf5FeCIv5LQ4wvyA83
         zSGWA0B9CQYf0hhAQm9810dFxfYbEotMguFxIV0TIHvnGv2+1fIdRBODkn7VHc3M9P
         zPVE752JfvfG//p4yIKQJE1Kg0ee/vdyr7dIPr2wVuJ2CBVSvX+mK2l8ZCV5K47u7y
         /DV3s+LSWiFrZt/cPyrElgCQtnrnEu8Fi4sVwVW8KVa6mVf2T15jw1ZgYx2jsURwgu
         RLtXGF/dz8s6Q==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KqozJleN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=FPmxDNgG4_xlF3046EEA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <linux-pm@vger.kernel.org>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "'Rafael Wysocki'" <rjw@rjwysocki.net>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Len Brown'" <lenb@kernel.org>
References: <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org> <85cdbc41f7f59a79b96793cbdcd49c53f964e46d.1565317135.git.viresh.kumar@linaro.org>
In-Reply-To: <85cdbc41f7f59a79b96793cbdcd49c53f964e46d.1565317135.git.viresh.kumar@linaro.org>
Subject: RE: [PATCH V5 2/2] cpufreq: intel_pstate: Implement QoS supported freq constraints
Date:   Thu, 8 Aug 2019 22:48:02 -0700
Message-ID: <001e01d54e76$037c4180$0a74c480$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVOWVya2W5jJ0NsR3CbiEAS4upLywAHDk0Q
X-CMAE-Envelope: MS4wfFFgQRQ0Myu0YxB0EfN0X8DDw4IkrfGkavkV8mRwFdQl1fMUoVXmnnFRq/fDppxqhT5cOVQ1UN/8eDwkHZqSO4yHjFGJNgA+YFukFy1nGBKtcIVlDRMn
 gACMCX7jOt+Z4wFJTMezZe4BA/uZfac/k183w+rQq/uepPELNQU62d3VwdmGm0Jigb05mo/fLgehIIPbFXz2UswjDYFevumNhggla53P7NIWogCjas5NpdcN
 eXv26qGt1yY1rrZo2dxtJJS5JYGD4k/9E63hSkx4k82FZi1th9A6UcG17pQAgWOtxVeaIOZTD73IVgJV/YWhwZ6JjB04aE8XhPvyHVMHWC38xEHO9xNTel+n
 GHjoSktCZZPIZZf7yEfSCIO02u28WPpfgS1p0SLtkp9IQ431tSw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.08.08 19:23 Viresh Kumar wrote:
> ---
> V4->V5:
> - dev_pm_qos_update_request() can return 1 in case of success, handle
>   that.

O.K. thanks,
That fixes the "Fail" messages I was getting with V4.

... Doug


