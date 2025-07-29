Return-Path: <linux-pm+bounces-31560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C194B150BB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F9E18A2723
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726332989A7;
	Tue, 29 Jul 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpefm7uy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174B2980B8;
	Tue, 29 Jul 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804838; cv=none; b=SDjaN6HWFblqItxP9TNJU8mPwvVZTRPYZht+xeP4yvFE2ybcexxiNxGJOta91/6rUqVubLzQM77uL8V8rpkhgh8+M4KIk3Fc9EvQWwsJz8ox6+V+/BVXHQoI/ZaZOalD85BEQsDwNHU57Q7hFavA/hFJqNOJLS+5Z7SfKzRSQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804838; c=relaxed/simple;
	bh=iYjQ08ZF98Az5gb3IAXe3bu00COVrd7SkiMkd5cwLFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+eZJRntOLkDKKVIA/XenVSwDuIS0wq0wahR8wfFNhcDMgnbC8kOFHKS1lKd9cw+sks3J1VBhEqkn9nQtNzxDAmN1V99Vr9T3lUP3LJoSoyRU4r5yHygmWwjkOSxbfnBFQcZSNNg6z+ZQ8nEQds11/AbR+6RxCf8MLEfDsYd+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpefm7uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F51AC4CEF5;
	Tue, 29 Jul 2025 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753804836;
	bh=iYjQ08ZF98Az5gb3IAXe3bu00COVrd7SkiMkd5cwLFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpefm7uykbqc9y7TVargxu/e++HZJInb6BzhsoQWK/FU3f1BthWHfcSVxL/9skwWC
	 aupAJUO/kiOpu8qezqBzZ6Lk3M1ZGYRo+Z2r0JoemTRCkplzQftrlvY7P4Oryp2c74
	 Kzqtc2HmMcsx8G+W8a02JhlB5asA8d4ZnFg/2+mWF054wprvRQOTlBv5zrjOZRrxCz
	 xm7SocZJvqiuBGio4byhbxw+SHJRotBg+26DbRB4Cn5icNESe+wso8HDEkJEiHuUko
	 rb8DLeEXxWvOyBhOz2e4GGfoMunXcDCIbaiTbhH0DQVnAG0xBIueO/ETo+frkdabjC
	 aDV9o2PoF5zfQ==
Date: Tue, 29 Jul 2025 11:00:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: power: qcom-rpmpd: sort out entries
Message-ID: <175380483538.477299.11633010175758794104.robh@kernel.org>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
 <20250718-rework-rpmhpd-rpmpd-v1-2-eedca108e540@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-2-eedca108e540@oss.qualcomm.com>


On Fri, 18 Jul 2025 19:13:40 +0300, Dmitry Baryshkov wrote:
> After removing RPMh PD indices, it becomes obvious that several entries
> don't follow the alphabetic sorting order. Move them in order to keep
> the file sorted.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 42 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


