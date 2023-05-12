Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1EC700F7B
	for <lists+linux-pm@lfdr.de>; Fri, 12 May 2023 21:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjELT5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 May 2023 15:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjELT5d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 May 2023 15:57:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106861AE
        for <linux-pm@vger.kernel.org>; Fri, 12 May 2023 12:57:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1861044066b.0
        for <linux-pm@vger.kernel.org>; Fri, 12 May 2023 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683921447; x=1686513447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlPMLuufIECZcT1zxsxn1hbMSVzD+mvP7zfZQnR0RRA=;
        b=DKBn7ZCl0YS2Kt9l6HjhHdI6QYFutE8YUJZztK9NY+emF5/XeMyNSExElPRaHuWBqV
         06q/+zwjPYKHiJt9J/LG4l3VFCCUlCQ8iLCZjjdTdkxAX4CK0eTu9YdcwOC7CR6LhQto
         2XRTatJgtgkvgkLCHj5Ik/hWp0eJ5PRRhUOsIsRoNWDarExbIDcGJ0RPRGO6du0Na4v0
         YhI2sPwr7X0QHV+ZL7CwvZbhoYkazXHmdYN1CT54CPrEacINf4GEwF3SMr3Fw9A2epJz
         LWFK45IOt79ytZ2WgzRDHq1lWPd6E4/Uw8MddfnjjEstdVAAMwS6bUJZtih7BPrQ4d42
         aliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683921447; x=1686513447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlPMLuufIECZcT1zxsxn1hbMSVzD+mvP7zfZQnR0RRA=;
        b=kyQHalw8GbaqNLfeMjLl9d3S3ea3xpakORfa+Zn1qDdgsW3K/SVAEGC5pfLjMK5/Dq
         dy9peD/Ai0Oxmq6XmL+aK1tVjvWEmEZ5zjzZPvwDR11RzxUt6u0DHkH+Uh6ICBYD+uGR
         ZUE/oK9UIS+P2jYPsRBKfAXHUVWrHHzXP+QzQRFq5cLiCYSQP+Igrr9tNX3bDqu0tUHx
         v9NvRZgXnKvhYQTHBgkRrsWVImcA1h9C4fF+q8sERXX6Ye06rAjbiCtrm57GBHaDAJmW
         pvlqvcTBIlcGPaJUWDLtrEL1sVB5Ujqdi5R/G2aQZDyOm5bAukFVCB64RDiY1ZMus/GJ
         iMpQ==
X-Gm-Message-State: AC+VfDwXn594M3rgbdGlsDEDm+Bc0GtO3h2SStVc8zyqNeH/FU/9eBTp
        ZK8i5uUx95/5QKav0Jj+y4Q=
X-Google-Smtp-Source: ACHHUZ70mOqMiqD6D+6W09TKUor3r0Q4zvgOXoePTvAHiwBw1zPV5032zoFrsS4nd7bq1dI2bUGZzg==
X-Received: by 2002:a17:907:3e88:b0:969:f0bd:5649 with SMTP id hs8-20020a1709073e8800b00969f0bd5649mr15281492ejc.60.1683921446953;
        Fri, 12 May 2023 12:57:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id jl21-20020a17090775d500b00965b5540ad7sm5906901ejc.17.2023.05.12.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:57:26 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id BA189BE2DE0; Fri, 12 May 2023 21:57:25 +0200 (CEST)
Date:   Fri, 12 May 2023 21:57:25 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: Bump soname version
Message-ID: <ZF6aJTqMkrlBb0Mm@eldamar.lan>
References: <20160610005619.GQ7555@decadent.org.uk>
 <ZFqV3ZFROy0m+/Xt@eldamar.lan>
 <eeca542a-eb7f-50a0-b62b-7bab8993185a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeca542a-eb7f-50a0-b62b-7bab8993185a@linuxfoundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuah,

Apologies for the delay!

On Tue, May 09, 2023 at 04:10:05PM -0600, Shuah Khan wrote:
> On 5/9/23 12:50, Salvatore Bonaccorso wrote:
> > Hi Thomas,
> > 
> > On Fri, Jun 10, 2016 at 01:56:20AM +0100, Ben Hutchings wrote:
> > > Several functions in the libcpupower API are renamed or removed in
> > > Linux 4.7.  This is an backward-incompatible ABI change, so the
> > > library soname should change from libcpupower.so.0 to
> > > libcpupower.so.1.
> > > 
> > > Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
> > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > ---
> > > I have to say the choice of variable names here is rather confusing.
> > > LIB_MIN is used for the soname version, which would normally be the
> > > *major* part of the version.
> > > 
> > > I'll send a second patch that switches to more conventional library
> > > versioning.
> > > 
> > > Ben.
> > > 
> > >   tools/power/cpupower/Makefile | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> > > index 8358863259c5..0b85f5915ce8 100644
> > > --- a/tools/power/cpupower/Makefile
> > > +++ b/tools/power/cpupower/Makefile
> > > @@ -64,7 +64,7 @@ DESTDIR ?=
> > >   VERSION=			$(shell ./utils/version-gen.sh)
> > >   LIB_MAJ=			0.0.1
> > > -LIB_MIN=			0
> > > +LIB_MIN=			1
> > >   PACKAGE =			cpupower
> > >   PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
> > 
> > Repinging this patch. Thomas, we are shipping it in Debian since, and
> > I'm wondering if the patch did just felt trough the cracks.
> > 
> 
> Please resend the patch for review.

Here is the patch again for a fresh review on it. If you want me to
send it standalone with '[RESEND PATCH]' I can do that as well.

Regards,
Salvatore

From 9091eb3294bad8f7d79eaff8f52ebeb02cc7d210 Mon Sep 17 00:00:00 2001
From: Ben Hutchings <ben@decadent.org.uk>
Date: Thu, 9 Jun 2016 23:35:08 +0100
Subject: [PATCH] cpupower: Bump soname version

Several functions in the libcpupower API are renamed or removed in
Linux 4.7.  This is an backward-incompatible ABI change, so the
library soname should change from libcpupower.so.0 to
libcpupower.so.1.

Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 59bfa05dec5d..dc531805a570 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -53,7 +53,7 @@ DESTDIR ?=
 
 VERSION:=			$(shell ./utils/version-gen.sh)
 LIB_MAJ=			0.0.1
-LIB_MIN=			0
+LIB_MIN=			1
 
 PACKAGE =			cpupower
 PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
-- 
2.40.1

