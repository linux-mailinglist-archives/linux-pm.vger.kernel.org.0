Return-Path: <linux-pm+bounces-11235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4408B93712C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046791F2109B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 23:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621B146A6B;
	Thu, 18 Jul 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQKtL87Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC08145FE3
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346208; cv=none; b=ShRI76+enraek33/bkCmJaYFUPdkjq+OKjAiS4bn/Ns5ZEYaWhfFgAN5TGQI0o8xS6PIlWb+vmqnPxcY9DfS4Ev1A/r8n64MXy+MU3neJUcDcsyLV2lRjRMN9GtzH4njJ4DFMbFyDGU5Zj1RKHsZslN14eUV2V7M7/16DAYTNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346208; c=relaxed/simple;
	bh=Fs8BMs6N/B/fxf7s4SP/Ab68hcA0mRBxxocOljHPwzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ieSP12bSJSOfSacy++tv3TVxm/qnxB7OjiOmGIyN+MGX0Rx+po3c5dN6g1jJbg6RI/LUfh10TfXBYHYBunb30zszdi0MOCJesVdiPK0C4GzD0R+pntcXpSqfAdhijxSEyLVQJ1n71bkfnRLub2OTklmJtLdEQ/1MfhgVeY4QF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQKtL87Y; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea79e689eso1588115e87.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346204; x=1721951004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2G6Wi/ghJW7ne1nL1LZ4kJtoZ1WxIyqIm9N6B8fvRMM=;
        b=lQKtL87YSjKAeWJ1Izcu8bBm0eHgThAiDHJcf8CN2ZbTsHVPDXW01gQmeiHMCOiVqL
         OZ4FSrx4M/V6gs79tp6CuxvIym3tI5xCSuplS4BC84wztNJA4u6zeg/k3kRvdP0nG7Z9
         kgUAPlhY5JHAb1KRDa75jjg5Z0KFNneYo3GsNVXsV4MaUI6mLyayQJIXWzy1CHrDxakh
         I+uN1Mijv1p+oeT5/76XeTxjnYHYW3LcLSl39H/Qy14EhIIXKyiniQ2O9U4IDmvQxVBm
         w4PSV5nEVux4/uUenuUt6RDVQCWraWtJwhRbPlF2YUMlwAO7Sy6TbecPhDdh6UHemjVe
         znOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346204; x=1721951004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G6Wi/ghJW7ne1nL1LZ4kJtoZ1WxIyqIm9N6B8fvRMM=;
        b=Mx2VqLuBrrwoOA4skRk70Tsiecl3slWkvkSUFpIK2MNHzY5HvtzzdkwCMg6o5QuPC+
         9asUU9JZRbuf++KuriTdwg7zSAhrE/DIQMPos3prjVk3IeTsbIQnv2QYgxsIvzG88FHb
         lYI+SYNL8erf0UlegWHEylh71C9nfJAbo6Bj+9r1xaGune4K3DBW9eloT5fhDBWEW+R5
         ZeP94bCjLj0NJzso6zd41JNYdnTrzH+nt52D2wI/Y/3q3w5H81haD5j+bDaAfo9LtPKz
         JL9WCmZV40j+AoY1WcP7zL0Dc8Gmr5oNyimquo7G2nPD2GwFpcVuIDqSPD9QdOzbNnYd
         wuPA==
X-Forwarded-Encrypted: i=1; AJvYcCXHU8vdhsF0C+RBJXGhqJE/pubRw93sArSAY7qyWF0d3wCJxmZB8Ndo3XjIOMdcp665XLDvAYwPJ1TEqZ7cf/jA85azn/j1rzc=
X-Gm-Message-State: AOJu0YwCOLAVv/xhr9dGAqMBunJfs8qND02Evz+L7w1JANK5/6o1Pfg2
	oaJUkcdLj2e5h3IladxTMg3JPSV+S7gtMtO5+ov2VxeBmuHuNgo0hkBuycYh5Ug=
X-Google-Smtp-Source: AGHT+IF+UwNsOHX2ZzNai2nhy5hTeg1HLABZ8GOiwqfPygMYjAAPG1DIHy5+fJSGlK3pIRK+hwampg==
X-Received: by 2002:a05:6512:3055:b0:52c:df83:a740 with SMTP id 2adb3069b0e04-52ee53d7630mr5487536e87.30.1721346204544;
        Thu, 18 Jul 2024 16:43:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:24 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] OPP/pmdomain: Assign required_devs for required OPPs through genpd
Date: Fri, 19 Jul 2024 01:43:13 +0200
Message-Id: <20240718234319.356451-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer drivers
to hook up a device to its PM domains. Their corresponding virtual devices that
are created by genpd during attach, are later being assigned as the
required_devs for the corresponding required OPPs.

In _opp_attach_genpd() we are also cross-checking whether the attached device's
required OPPs really belongs to its PM domain's OPP table - and tries to fix it
up if possible. In principle this works fine, but sometimes it's not convenient
for consumer drivers to use _opp_attach_genpd().  Especially in the single PM
domain case, when a device is usually attached by the bus-level ->probe()
callbacks.

Moreover, we now have dev_pm_domain_attach|detach_list() that helps consumer
drivers to attach their devices to their PM domains.

To improve the situation, this series moves genpd to assign the required_devs
during device attach in genpd, which makes the cross-check of the OPP table to
always get done.

Note that, we still need to support the existing users of _opp_attach_genpd(),
which makes this series slightly complicated. Once we have migrated those users
to dev_pm_domain_attach|detach_list(), we should be able to remove
_opp_attach_genpd() altogether.

To test this, I have used a QEMU setup, with local PM test-drivers to try to
test all various combinations of single/multi power/performance PM domains for
a device. Hopefully I have covered it all, but I would certainly appreciate if
someone could help to run a slew of tests on some HWs.

Kind regards
Ulf Hansson

Ulf Hansson (6):
  OPP: Fix support for required OPPs for multiple PM domains
  OPP: Rework _set_required_devs() to manage a single device per call
  pmdomain: core: Manage the default required OPP from a separate
    function
  OPP/pmdomain: Set the required_dev for a required OPP during genpd
    attach
  pmdomain: core: Drop the redundant dev_to_genpd_dev()
  OPP: Drop redundant code in _link_required_opps()

 drivers/opp/core.c        | 182 ++++++++++++++++++--------------------
 drivers/opp/of.c          |  39 +-------
 drivers/opp/opp.h         |   4 +-
 drivers/pmdomain/core.c   | 107 +++++++++++++++++-----
 include/linux/pm_domain.h |   6 --
 include/linux/pm_opp.h    |  10 ++-
 6 files changed, 183 insertions(+), 165 deletions(-)

-- 
2.34.1


