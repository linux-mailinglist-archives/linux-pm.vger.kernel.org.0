Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74887071A8
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 21:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEQTNS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 15:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEQTNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 15:13:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1AD048
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 12:12:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96aadfb19d7so213211566b.2
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684350772; x=1686942772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg7aa6rGixnPDdMq5SgG5JDB3rrbOdjyWkfzs80Xjvg=;
        b=dedaCCxrOg1IZdkHT5ynsWfY6ff3jBjwDPiRat+h673Hdlg4oghnAEyuo3mm1dpD1s
         P7nVdCDfhCKhx31sTKWToNMSvl+fbJBs07lUbKpy3i+LoBWlO4UfNPFl4pwv/SD1iCNe
         j8Z8JUJSU8VZ7g/dsE5OJanBC3KUeFLLEHTTuangIA5Z/8YKebfIoOzfOXnSdQDxdPRS
         uoR0nCgEWBLwCzamvAoSfh/ivl2tj0+j8OsyH3m0PsP1ncGpbCG9WwXQAqK5KqZR8gW1
         mPFwX1bsg9b7nRcFbjeEvGYmZfS/hpisOzojeX9NQB2oRIr515lAVP27C7wYRZItS5/K
         TPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350772; x=1686942772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg7aa6rGixnPDdMq5SgG5JDB3rrbOdjyWkfzs80Xjvg=;
        b=MJv7edeJa0jmlrldwwf6AhQi/h91XVXkiJTqsnCitZ/t1GeZcx19NztyX1FSKT+A3q
         HEqQVzSKMuyIYU6QKmIAfrGW1naqs9qnYYlZkWO/sQINS1h09OPdjtupaAOnt/6rfjSf
         pJbcBd5AiQjFGPo+widg9wyu9ciqf/QjO+NODMO0psFAGtiIFMR0qOofHCIcGuzzo/4P
         vy1jDwXmCv+iz+/q7eDi9uMYv531ohShB3xPaEcbYxRpiaKFPjiwSHDDDNHuKIOzksC3
         +opefGB2m8VsLKEK3C7AnS6K+g4hKbBKMr572WP1TT7CH6enoJQ9FmDU0Kr0wrXCiwMR
         0RJQ==
X-Gm-Message-State: AC+VfDyk4xhDZWw24mToCK1CRxxnwdRoV8d72RQdnas3ypkatwD4qdZj
        nyW0S6uZ5Bs1eIz12QktZX4=
X-Google-Smtp-Source: ACHHUZ6lxTX3haKJtOwiVbsHigCvxeO5SY/4SixZ28+96rFhp4jUUaJhjOAvuPbpy2+gnGbhd2mLeQ==
X-Received: by 2002:a17:907:843:b0:94f:5847:8ac with SMTP id ww3-20020a170907084300b0094f584708acmr40119468ejb.51.1684350772286;
        Wed, 17 May 2023 12:12:52 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id og40-20020a1709071de800b0095807ab4b57sm12839391ejc.178.2023.05.17.12.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:12:51 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id A6918BE2DE0; Wed, 17 May 2023 21:12:50 +0200 (CEST)
Date:   Wed, 17 May 2023 21:12:50 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: Bump soname version
Message-ID: <ZGUnMq9qnzPNsZQL@eldamar.lan>
References: <20160610005619.GQ7555@decadent.org.uk>
 <ZFqV3ZFROy0m+/Xt@eldamar.lan>
 <eeca542a-eb7f-50a0-b62b-7bab8993185a@linuxfoundation.org>
 <ZF6aJTqMkrlBb0Mm@eldamar.lan>
 <d56c18e8-863b-1131-64dd-c84aeab1e968@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d56c18e8-863b-1131-64dd-c84aeab1e968@linuxfoundation.org>
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

Hi,

On Wed, May 17, 2023 at 11:53:59AM -0600, Shuah Khan wrote:
> On 5/12/23 13:57, Salvatore Bonaccorso wrote:
> > Hi Shuah,
> > 
> > Apologies for the delay!
> > 
> > On Tue, May 09, 2023 at 04:10:05PM -0600, Shuah Khan wrote:
> > > On 5/9/23 12:50, Salvatore Bonaccorso wrote:
> > > > Hi Thomas,
> > > > 
> > > > On Fri, Jun 10, 2016 at 01:56:20AM +0100, Ben Hutchings wrote:
> > > > > Several functions in the libcpupower API are renamed or removed in
> > > > > Linux 4.7.  This is an backward-incompatible ABI change, so the
> > > > > library soname should change from libcpupower.so.0 to
> > > > > libcpupower.so.1.
> > > > > 
> > > > > Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
> > > > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > > > ---
> > > > > I have to say the choice of variable names here is rather confusing.
> > > > > LIB_MIN is used for the soname version, which would normally be the
> > > > > *major* part of the version.
> > > > > 
> > > > > I'll send a second patch that switches to more conventional library
> > > > > versioning.
> > > > > 
> > > > > Ben.
> > > > > 
> > > > >    tools/power/cpupower/Makefile | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> > > > > index 8358863259c5..0b85f5915ce8 100644
> > > > > --- a/tools/power/cpupower/Makefile
> > > > > +++ b/tools/power/cpupower/Makefile
> > > > > @@ -64,7 +64,7 @@ DESTDIR ?=
> > > > >    VERSION=			$(shell ./utils/version-gen.sh)
> > > > >    LIB_MAJ=			0.0.1
> > > > > -LIB_MIN=			0
> > > > > +LIB_MIN=			1
> > > > >    PACKAGE =			cpupower
> > > > >    PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
> > > > 
> > > > Repinging this patch. Thomas, we are shipping it in Debian since, and
> > > > I'm wondering if the patch did just felt trough the cracks.
> > > > 
> > > 
> > > Please resend the patch for review.
> > 
> > Here is the patch again for a fresh review on it. If you want me to
> > send it standalone with '[RESEND PATCH]' I can do that as well.
> > 
> 
> Yes please resend with RESEND tag. I won't be able to apply the patch
> when it is included in the reply.

Thanks for your patience! Just resent the patch as requested:
https://lore.kernel.org/linux-pm/20230517191019.643031-1-carnil@debian.org/

Regards,
Salvatore
