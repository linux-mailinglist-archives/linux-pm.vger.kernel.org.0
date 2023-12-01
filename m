Return-Path: <linux-pm+bounces-588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E7800382
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 07:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45612814DD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 06:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12963BE5C;
	Fri,  1 Dec 2023 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MseYhNtR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25076193
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 22:06:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-286447abfbeso899308a91.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 22:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701410766; x=1702015566; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYvqfpip/7tjf7a0T470OB2s3N6lg3+olHWW3HxMKLI=;
        b=MseYhNtR/m+0m4P0qByblws9UWYRClINp/lGqdaIlEFkPrmV6p15MByjIFGR5OZ+VQ
         oMEGDUmG6UCtxoz4cXGGAGMH90az3ZfED5/LrM9btPwcT15eXRcqHn1sdg4dXr9Z+SPo
         qslJ4BcIaoiWsbNGIxqdMz0DOEkT4izXWcuQLGdX8hGfmUPWZB6LW1MM++fAh4uxz2fC
         VCiKVRwDIXJ4r5iHXwPXoZtiHXTjL5Mck/RhH6qtj5pQCiunD5QOKXwFllES/EpEtZot
         RpeUnArgk3xdor4LtxhF2ydSXvnwhxJUQtsiu+FlkHDRHw/EesmubDXu0z7kHr1WTM6x
         4KWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701410766; x=1702015566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYvqfpip/7tjf7a0T470OB2s3N6lg3+olHWW3HxMKLI=;
        b=MPPa38KYbJhh07YFRlCXV1oNkYqVYHTU3yatKo/LIXbikkmjdVG1dEbfGIax6WgMn8
         5lfifhQwC73zJNzIO5vRkLfNwQ2hu5J2UuqdqrBycTehoZYr4SYk5jxBfmCFwrSW4aNo
         ChRHoah2lW4jtdYBZpPzgA5FUkxdoF9LNiUr043NtwvoqAB2Ic3CPNNeYz1sZDW7I3H8
         ZS5OoMUHZUiHLiWq4508nZyWeD2gcvuT1SRMKaH7ftGgFP5GXj5zHe2X0vKEDsqOJCTK
         VfoIxoHeF4rK+CW8Mru3sDGcD6pSPgV5p98GxxKnaHXFkl4rV4JdlfEzfvTk8OKAJ1cn
         urag==
X-Gm-Message-State: AOJu0YxZMr1KO+ilwSSlMtu8uwQmSdLwXIz94lFkdBGqhxfUgJfsZzib
	p65AYAn2yjMCLY/PLSfySdRqeA==
X-Google-Smtp-Source: AGHT+IHMHRgjNA+riSKx/LyeestHqu5449BJw68CWUaBswo+1/jxcf5fYHStpMmWA/migrCxEF8BSg==
X-Received: by 2002:a17:90a:f48c:b0:285:490d:10cd with SMTP id bx12-20020a17090af48c00b00285490d10cdmr37691368pjb.3.1701410766260;
        Thu, 30 Nov 2023 22:06:06 -0800 (PST)
Received: from google.com (218.180.124.34.bc.googleusercontent.com. [34.124.180.218])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfba9dac6esm2439258plg.115.2023.11.30.22.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:06:05 -0800 (PST)
Date: Fri, 1 Dec 2023 11:35:57 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-pm@vger.kernel.org, manugautam@google.com, mshavit@google.com,
	quangh@google.com, vamshigajjela@google.com
Subject: Lets not expect domains marked as `RPM_ALWAYS_ON`/`ALWAYS_ON` to be
 ON at boot
Message-ID: <ZWl3xd7lc5pnnIcz@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linux PM experts

For a given power domain, if the `genpd->flags` has the GENPD_FLAG_RPM_ALWAYS_ON
flag set, then pm_genpd_init expects that domain to be ON:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/domain.c?h=v6.7-rc3#n2102

I have a usecase where the power domain is not ON by default on kernel boot,
but I also want it to stay ON during RPM. But the current logic fails the
`pm_genpd_init` for me.

IMO, the kernel should not force a PD which needs to stay ON during RPM to be ON
at boot also. It is quite possible that the PD will be turned ON for the very
first time by a client driver in the kernel itself.

Additionally, I think the kernel as well should not enforce this for PDs which 
do not want to turn OFF ever, i.e., the ones which have `GENPD_FLAG_ALWAYS_ON`
flag set. Let the kernel turn ON these PDs when it wants and only then prevent
the RPM or system suspend from turning these domains OFF.

Proposed patch in pm_genpd_init:
```
-       /* Always-on domains must be powered on at initialization. */
-       if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
-                       !genpd_status_on(genpd)) {
-               pr_err("always-on PM domain %s is not on\n", genpd->name);
-               return -EINVAL;
-       }
-
```

Looking for your views here.

Thanks
Ajay

