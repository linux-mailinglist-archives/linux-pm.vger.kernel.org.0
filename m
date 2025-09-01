Return-Path: <linux-pm+bounces-33587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89BBB3EF27
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 22:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3761A8676F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CAA226D02;
	Mon,  1 Sep 2025 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md6hGjPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E24409;
	Mon,  1 Sep 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757130; cv=none; b=czpyIfUHxNDbOIrHPvsbSXf6jxvsEZwzqn7t17j0hxrRfPVE4BkHavNJ0PTdA02RfPJsRz/0rnTsiZSWiAn/0FOh8INR63/09NjmJPm1h5oaZoVk57sRxrv8HmlB3lru9nBAyP+zDr1XXY3Nq1SRk511zyMA5tq21E5K+DmHZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757130; c=relaxed/simple;
	bh=RAim03favvAaUeqPJwCMd2IVGw1/U66PABzxHIdIwiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnlQXFqO2dXSferFd/rPRiFIXgEUwjQk+TiqYA8gM+ZCE7Pq2wMonfEQNUyogskuW77NmM6l4DDmsNlFW17xIsoTSny5eHPPl1cIDA+cciCuZF6SaJagJ3DlDIdWocvsL1M3fRpp1ksqwJiUj9Li0kR2tIBIjWY2i4bUV0nCR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md6hGjPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034F1C4CEF0;
	Mon,  1 Sep 2025 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756757130;
	bh=RAim03favvAaUeqPJwCMd2IVGw1/U66PABzxHIdIwiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Md6hGjPbHG5zimFZFjh3NJDnJu5+ynifyjubmfmOqKPWU5EQqbRPY8mgS9SR34b20
	 KXLKVrBS7jtKhzUNk0gc2JapL24eK3LJ8EY9xm2CoEbj+uQ2kPLhm/VSM3OIdckKs+
	 kUJtDbZRjOQwHaGmzSdcarReJQ0ZTU2qkTkttUJs4D/RSMDxneGQZ/va5Xf/J18Hqi
	 T6n4EW+W1xlQO9CwlNybVXOzIOXhlW89lTdd26jN9l+FeiPZ+/4fPj6qS5uMgpvVFv
	 AHWauX3trQXxKiuxkYRagYWIMWxBJqvp/nITLKSJ3brlbuhEndLe6ObwXpikyO3jJL
	 iivAHPeazk8Dw==
Date: Mon, 1 Sep 2025 15:05:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>, linux-usb@vger.kernel.org,
	kernel@oss.qualcomm.com, linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Collins <david.collins@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
	=?iso-8859-1?Q?Gy=F6rgy?= Kurucz <me@kuruczgy.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 6/8] dt-bindings: soc: qcom,pmic-glink: Add charge
 limit nvmem properties
Message-ID: <175675712869.236292.8855356859371359871.robh@kernel.org>
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
 <20250826-qcom_battmgr_update-v3-6-74ea410ef146@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-qcom_battmgr_update-v3-6-74ea410ef146@oss.qualcomm.com>


On Tue, 26 Aug 2025 15:18:33 +0800, Fenglin Wu wrote:
> Add nvmem properties to retrieve charge control configurations
> from the PMIC SDAM registers.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


