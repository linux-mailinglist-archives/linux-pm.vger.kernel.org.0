Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6337918595E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCOCri convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 14 Mar 2020 22:47:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57134 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgCOCri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 22:47:38 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 4a46121284671a62; Sat, 14 Mar 2020 11:47:36 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alex Hung <alex.hung@canonical.com>
Cc:     viresh.kumar@linaro.org, corbet@lwn.net, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: intel_pstate: update links for references
Date:   Sat, 14 Mar 2020 11:47:35 +0100
Message-ID: <2292804.jGeqd3P1IT@kreacher>
In-Reply-To: <20200306002350.9166-1-alex.hung@canonical.com>
References: <20200306002350.9166-1-alex.hung@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, March 6, 2020 1:23:50 AM CET Alex Hung wrote:
> URLs for presentation and Intel Software Developer’s Manual are updated
> as they were using "http" which are gradually replaced by "https".
> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
> index 67e414e34f37..ad392f3aee06 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -734,10 +734,10 @@ References
>  ==========
>  
>  .. [1] Kristen Accardi, *Balancing Power and Performance in the Linux Kernel*,
> -       http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEurope_2015.pdf
> +       https://events.static.linuxfound.org/sites/events/files/slides/LinuxConEurope_2015.pdf
>  
>  .. [2] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 3: System Programming Guide*,
> -       http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
> +       https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
>  
>  .. [3] *Advanced Configuration and Power Interface Specification*,
>         https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> 

Applied as 5.7 material, thanks!



