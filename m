Return-Path: <linux-pm+bounces-41846-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEOWCzRLfmmqWwIAu9opvQ
	(envelope-from <linux-pm+bounces-41846-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 19:34:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33DC385B
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 19:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D33302A6F1
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A0366833;
	Sat, 31 Jan 2026 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQC2dZAa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ADA340DB1;
	Sat, 31 Jan 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884460; cv=none; b=tTXyK/jmBTIxqEx4HKAsJGjBHANoD7hjdYdELnMdxgCzq1kkGDPone2oQHcv2Fvr1qw4epuItpfdqmBW/ZUDpKzaD9DLVBI2LRpXyOtIlkE4t0noyCveZvyGupMhVjpVmVSF4EAO404ypr7QtDO5FB0P7AtWeXecUao586DSzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884460; c=relaxed/simple;
	bh=aaE7fKEwlpHt4wn74V9tbscqWqdbeDceUSgbkf29J3Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tb7lxkC1MS8J3LBtBNYlJLw8X2OPIT5ozUahZuRbfyAzId7RPPmwYcaJSTVmyKlZq/cZu9MCSJcwnPVrZTjOnL98pYU9kuafULco5Vr3LbfEvEYcbe2m5+OBK4q9hdKqwDdphLIDeDL/FUdnSYBlrkNm2LzyUBMPkEAuzGRppVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQC2dZAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84035C4CEF1;
	Sat, 31 Jan 2026 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769884460;
	bh=aaE7fKEwlpHt4wn74V9tbscqWqdbeDceUSgbkf29J3Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YQC2dZAaz6ouQyaaU7Z+wFs6TTiYA+yKw8t6OwJjvBghr+V6TwdAFyh8WNHBkwvR/
	 ZoPGUyXVEw5NXaUyWHBiOrv+g8M1Z5ShTW3ud41iTO8/sw5RneF7ni10xq+nIhnKWN
	 Hy9mLtn+Jt2HkDYBz1LiqR0rddpZmYEmJMFXyXviPxcOxg0hiZldBR80N0hvEakOhn
	 w6mbPePNlUck8B0rvlIRzE0x5HtVG6qF7ioLEsQfV+BPk68IEmBrBY7xr8ahuUbyHa
	 eHp7XpOv4jGulvJimI7k7g7eoFHGCVn0K6tMxuWMNQdMH0+L4NkBykdr84dSOGPizH
	 x9Aow3hHbKxnA==
Date: Sat, 31 Jan 2026 12:34:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dikshita Agarwal <dikshita@qti.qualcomm.com>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-pm@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260131-iris-venus-fix-sm8250-v1-1-b635ee66284c@oss.qualcomm.com>
References: <20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com>
 <20260131-iris-venus-fix-sm8250-v1-1-b635ee66284c@oss.qualcomm.com>
Message-Id: <176988445972.2807015.8710676873473596056.robh@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: clock: qcom,sm8250-videocc: account
 for the MX domain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41846-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,huawei,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: CC33DC385B
X-Rspamd-Action: no action


On Sat, 31 Jan 2026 19:33:43 +0200, Dmitry Baryshkov wrote:
> To configure the video PLLs and enable the video GDSCs on SM8250,
> platform, the MX rail must be ON along with MMCX. Split the bindings
> file in order to provide separate file utilizing MMCX and MX power
> domains.
> 
> Fixes: dafb992a95e1 ("dt-bindings: clock: add SM8250 QCOM video clock bindings")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/clock/qcom,sm8250-videocc.yaml        | 80 ++++++++++++++++++++++
>  .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 ------
>  2 files changed, 80 insertions(+), 20 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.example.dtb: clock-controller@ab00000 (qcom,sm8250-videocc): clock-names:0: 'iface' was expected
	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8250-videocc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.example.dtb: clock-controller@ab00000 (qcom,sm8250-videocc): clock-names: ['bi_tcxo'] is too short
	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8250-videocc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.example.dtb: clock-controller@ab00000 (qcom,sm8250-videocc): clocks: [[4294967295, 0]] is too short
	from schema $id: http://devicetree.org/schemas/clock/qcom,sm8250-videocc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260131-iris-venus-fix-sm8250-v1-1-b635ee66284c@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


