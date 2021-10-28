Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BE43E6DF
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhJ1RNR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 13:13:17 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:54729 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbhJ1RNR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 13:13:17 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AGJpiAK0+5EntTj2VtfbD5WBzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJgWgm02YDmGUfDG+Gb/yPMTened1/aoq29x5TuZHUy4U2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRHuCsULS?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?lm7rhc0AMKlLQFVjTzCQGHfH4214b+XdaPqUTbZLwbW9VljGIlpZ1wcpEsZiYS?=
 =?us-ascii?q?AEzP6SKlv51vxxwSnkkZ/IZp9crJlD666R/1Xbuf2Dp0uluDUwtFZEV/vtsR2d?=
 =?us-ascii?q?D6ZQwMyoMaBGdjvnw2Lu9RvNxmM0vJeHvPYUCqjdhyy3UCbAtRpWra6HH49Vw3?=
 =?us-ascii?q?zoqgM1KW/HEaKIxczhwRA7CfAxUPVwUCdQ4kfvArmf+aTBDqBSWuK8++UDXzQp?=
 =?us-ascii?q?4yr+rN8DaEvSORMNIjgOAo0rY8GnjRBIXLtqSzXyC6H3EruvOmz7rHYEfDru18?=
 =?us-ascii?q?tZ0j1CJgG8eEhsbUR28u/bRt6IUc7qzMGRNpXFo9PJrshL7CImgGQe1vjifsAR?=
 =?us-ascii?q?aXddMe9DWITqlksL8izt1zEBdJtKZVOEbiQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aue7oYatwqwOcuG9rDm9G7+hw7skDYdV00zEX?=
 =?us-ascii?q?/kB9WHVpm6uj5qWTdZUgpH3JYVMqKRUdcL+7VJVoLUmyyXcN2+ks1NSZLWrbUQ?=
 =?us-ascii?q?mTTb2KhLGKq1bd8kvFmNK1vp0MT0ERMrfNMWQ=3D?=
X-IronPort-AV: E=Sophos;i="5.87,190,1631570400"; 
   d="scan'208";a="1022777"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 19:10:48 +0200
Date:   Thu, 28 Oct 2021 19:10:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Doug Smythies <dsmythies@telus.net>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem in changing from active to passive mode
In-Reply-To: <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110281908150.9518@hadrien>
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien> <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com> <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Now, for your graph 3, are you saying this pseudo
> code of the process is repeatable?:
>
> Power up the system, booting kernel 5.9
> switch to passive/schedutil.
> wait X minutes for system to settle
> do benchmark, result ~13 seconds
> re-boot to kernel 5.15-RC
> switch to passive/schedutil.
> wait X minutes for system to settle
> do benchmark, result ~40 seconds
> re-boot to kernel 5.9
> switch to passive/schedutil.
> wait X minutes for system to settle
> do benchmark, result ~28 seconds

In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
register is 0 and in the second boot (after booting 5.15 and entering
passive mode) it is 10.  I don't know though if this is a bug or a
feature...

julia
