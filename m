Return-Path: <linux-pm+bounces-9581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B790EFB6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0881F215F5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E638414E2E1;
	Wed, 19 Jun 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9VE0pQM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A7D26A
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806147; cv=none; b=eDbuS601O8Utg1G9wPIpFDKB0n1/pH48T23UnOebtNc9u0GI8BPY49xZrvSocYqdr0+blOLXE5+QXXgJBtQX7iXF9jEZDZAHxIqoTMHD0CrZWuiozzgrEgszigEnE5k7U8ArOoqFscwiheseFDwwPN963tEDvFCQCJEmiCu86gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806147; c=relaxed/simple;
	bh=xxBk4Vi2ofgvIr6TnMk1h9bALTrj2WDTbCiUrt1MBl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ps79Ik5OaBYDT87q3cRW+O/5XnOrB2LvmK8DbreaKQxyjJ/NHS+QRS9SxEyFlxK+PQea8s+ZP0EDrUA0nP4Eo0fEJd2D7yMxXt6BpV9EhxYmC+H2LM0Jt/OFd4kif5FjMrqDtk6f4YAASvA8Ry9VVQG/+v00XJTw1Dbi7hqsZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q9VE0pQM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cccd44570so691878e87.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806144; x=1719410944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvycpBB6sFeiiSCGvfkTFvRas6FqApeihphIpdqcmcs=;
        b=q9VE0pQMDwp4YFv2w8V5U7dN7e0Z0Jb7Oe7Zmj5d+C4XNP/uH58lJ7A1ruWfEFYFXW
         duYyNOe0iF6tzzXV0U8E674OEMgoMritsrliTXn+NXh7ZqJsG0NL2HSp82YS4VxXtkH0
         LKoUkk3HxvEdABghlRPAKYqa14/u68Cw4L2eW74T/GjwpaC+NJpGtKe/+UAQZokhvBRB
         ByVfN7kK9HobkRLAI+MWwNl0rMeuEAzez6F7GHD4N9jAgg1XpHES3P+lDBcxZhzhJfMw
         IQAFLR8jx5+gmwDhKSm9TYaTC6ywHXMuVzrmroSmHFTGEzC5xC97YgpyEBpgkcfkrE6V
         iqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806144; x=1719410944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvycpBB6sFeiiSCGvfkTFvRas6FqApeihphIpdqcmcs=;
        b=XpeMkrz8c5QX4IGd62p+YeqB6vEwz0tU/HeBllMQS0Il8gCpt3SzH6JSYkIu4Yw0Wd
         BOAOQo49uQiOgKtdm9F4J7yphcW4iMlrzbUG4fLNVE+GoZXmDeX2hluDB4x+6NwsCDVn
         7SZedGpPC0fBezYVJJnTkxNXE3lidVuAjqYuNVIA9XQw62EmRJ6RP+QncXMQ+12RsPet
         zYFJjWeIGFFGyfZjSAfjR+Jz5l8i3Nc8+O5fd/Rpdjw0INFfBz0gAj3cj/bFo0B0c/xX
         npeMlEx2SpWcXWpdB7EezXtyJ937EmYKIb8XGILNJ84BmRAcnF9lMidjc2fEFz1llVV6
         3VDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9QFfN7rt7YLYE1v17ZjRhPQ1yH+h7koZjkjtFvkJBTWZRDizy8eTTjaWSVqnVLezRiNvvRF80ECDMvMjiBrsqfJqizSZzucg=
X-Gm-Message-State: AOJu0YxVaDS8MyKte74DCj0W3naII5QYDekCflK4znN6iA5vcuiw69t0
	1KzMAVWmHRr/hxPaGH4GPaoNcMjYiEX2vBBdLGr9q35B0IkBtLwvg27CuB51gAk=
X-Google-Smtp-Source: AGHT+IFI0Nyk+muBONfseoLj9XtYy+0CZu9z+FKo2et/S8eFchtWWMGZOEkfH8LH6NNHHXpvJVbrEg==
X-Received: by 2002:a05:6512:3c9e:b0:52b:82d5:8fd2 with SMTP id 2adb3069b0e04-52ccaa97444mr1959568e87.47.1718806144420;
        Wed, 19 Jun 2024 07:09:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:03 -0700 (PDT)
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
Subject: [PATCH 0/7] OPP/pmdomain: Assign required_devs for required OPPs through genpd
Date: Wed, 19 Jun 2024 16:08:42 +0200
Message-Id: <20240619140849.368580-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
drivers to hook up a device to its PM domains. This works for both a single
and multiple PM domains. Their corresponding virtual devices that are
created by genpd during attach, are later being assigned as the
required_devs for the corresponding required OPPs.

In principle this works fine, but there are some problems. Especially as
the index for a "required-opps" may not necessarily need to match the index
for the "power-domain" in DT, in which case things gets screwed up.

This series intends to improve the situation, but it's also the first step to
enable consumers of _opp_attach_genpd() to start migrating to use the new
dev_pm_domain_attach_list() instead. Down the road, we should then be able to
drop _opp_attach_genpd() completely.

To test this, I have used a QEMU setup, with local PM test-drivers to try to
test all various combinations of single/multi power/performance PM domains for
a device. Hopefully I have covered it all, but I would certainly appreciate if
someone could help to run a slew of tests on some HWs.

Note: Patch1 is actually a fix that has been posted [1] separately too. I
decided to include here for completeness.

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/linux-kernel/20240618155013.323322-1-ulf.hansson@linaro.org/

Ulf Hansson (7):
  OPP: Fix support for required OPPs for multiple PM domains
  OPP: Drop a redundant in-parameter to _set_opp_level()
  OPP: Rework _set_required_devs() to manage a single device per call
  OPP: Introduce an OF helper function to inform if required-opps is
    used
  pmdomain: core: Manage the default required OPP from a separate
    function
  OPP/pmdomain: Set the required_dev for a required OPP during genpd
    attach
  pmdomain: core: Drop the redundant dev_to_genpd_dev()

 drivers/opp/core.c        | 185 ++++++++++++++++++--------------------
 drivers/opp/of.c          |  32 +++++++
 drivers/opp/opp.h         |   4 +-
 drivers/pmdomain/core.c   | 103 ++++++++++++++++-----
 include/linux/pm_domain.h |   6 --
 include/linux/pm_opp.h    |  16 +++-
 6 files changed, 215 insertions(+), 131 deletions(-)

-- 
2.34.1


