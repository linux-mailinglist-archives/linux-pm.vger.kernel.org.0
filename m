Return-Path: <linux-pm+bounces-19536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852CC9F84B2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C7E1893DAF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355E1BD9CB;
	Thu, 19 Dec 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKbM/QTM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCE1A2554;
	Thu, 19 Dec 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734637651; cv=none; b=i+7dyGmPmj01hQq6O6KOSh9lg5hGG1CdiD6D7sDDzzDdBFSeJtknCf9y+ckfFGApacfaezhKP4HphRKrsWWVy49JCrm60WmBq4EiJm12kPD//QlzLI/KS7cXwxgTirLpjd1o3rmH3QNuDcKCfqb4ezFjjWRyzuI+tER8FSVRGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734637651; c=relaxed/simple;
	bh=rTs2IJmXMK8DKupmfPhHlLT82XzyZHK89QVwlzddCpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2B9bzKckbWw8jxjO4Dgezze4NoT9nQxnwdZD1PaOjubJCkbDtikxfkdPVy/Sw58hcOX8fmatdnBUR7XPR4jNxT78Nc6T/EmbL9KB8dH7HqCEtaolPtarbbc4RJ5btJ2uV1huK4Su0VSn+/sIg3hZn81CCuea/EBgy+Br6bWtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKbM/QTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715AEC4CED0;
	Thu, 19 Dec 2024 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734637651;
	bh=rTs2IJmXMK8DKupmfPhHlLT82XzyZHK89QVwlzddCpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKbM/QTMytVKJZqb4rydKtEIJspNeexbzY6cFYh39lgNmhBmoqDTamowZWndktWXL
	 j3Vri/j1VzPaTmzo4Gbn2GTSjnfDz24XKbDY3++FMzPN3TukWBIsFmUvOuo2y23JqE
	 rakhFc8xMeTzmjJX6JLD47IOakcZhUUa4zTStbE/Lo422uFqRAxIpli+uXVPDT8Vzc
	 +Ys0Kfrvm5x8g7F6fsSXyAyFPXJdNClytGS64krv1YPn7A3NxsFAH+SwnMTCgvB2sV
	 pyuHn0G97jL8+gAZfeNwxF5bnnK2gDJtZzysjggBNjTuTHK3JlgdmjI/qsEIYKQcwG
	 lRBWDlFRNzixA==
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	Dang Huynh <danct12@riseup.net>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/8] Add MSM8917/PM8937/Redmi 5A
Date: Thu, 19 Dec 2024 19:47:09 +0000
Message-Id: <173462257281.3911097.5906559750922143439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 15 Dec 2024 12:14:55 +0100, Barnabás Czémán wrote:
> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
> 
> 

Applied SMMU bindings change to will (for-joerg/arm-smmu/bindings), thanks!

[4/8] dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU to SMMUv1 compatibles
      https://git.kernel.org/will/c/8735e47e3a29

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

