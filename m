Return-Path: <linux-pm+bounces-10142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D4D91B028
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F51F24020
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3319DF68;
	Thu, 27 Jun 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAXc3CAt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D219D071;
	Thu, 27 Jun 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519045; cv=none; b=C6ePZRoIuuu9WUe8JxneLXBnoU8ARLh+O/tsJC4ffnAh1KsriYN4mJMHi21508Ze/jB7cTjYGPqjnFpYY4rS01RAtQiv5K6P9YbaKf0FeObJEG/sIsBzK5KsJwQ3aUZ6NZKqTAwTVSobyyxhQAbKQdchYCI1JHJm3rJ4hYcTdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519045; c=relaxed/simple;
	bh=mYZr87v6ibAo2OlmRNIuM9tKRKlKn84LWqsUifYTFBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQJgdN5PoW0VNhqj7PEBsPc7GebrXwB3j86fCd9ziT0BZNFE9cXjq5uHuX4ZiNKqJIVTZMJAspunKUbY/0A6AsPNj7iiYUIvGmeAs2iDRWzC0TRkK17cVyd5tP14DkHKQkgTV3319AxkultSUdF4ZOGcM4d02/optxRsmtMRHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAXc3CAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF50C2BBFC;
	Thu, 27 Jun 2024 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719519044;
	bh=mYZr87v6ibAo2OlmRNIuM9tKRKlKn84LWqsUifYTFBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAXc3CAtGSBmIKKNUgtpCDBED6l09/SNSCoZZmmbmUTPYPNU/QBhiBp6t9tD8fB8T
	 X3b6lFx/rEM8xRwP6Whu2Rnkh5RqPkp/IJca7as+dyMA0yj1xtcfTMzgh2G7SPa/A+
	 5Qs6uCpEWXP302RR37Us1GxF7SW9MxdwSgR5sy9daKqWmogC9k8ccdhhvRbBAwduHN
	 I6uYKr4k9Nu+uaRnNMCi7QfWYUg0leH8e2vsxHzaQRs+ruN54uwQWOH6FeXC83YBzU
	 c3jLWn+ahxJy4hutQfXmXd6Rlsfu6sifkjFJoRYiR7YRQiRmo6jrVAHvmiooU3tot1
	 UkbayKt2FApoQ==
Date: Thu, 27 Jun 2024 14:10:43 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Melody Olvera <quic_molvera@quicinc.com>,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Message-ID: <171951904084.453846.10563546710745374942.robh@kernel.org>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-1-086950f650c8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-arm-psci-system_reset2-vendor-reboots-v5-1-086950f650c8@quicinc.com>


On Mon, 17 Jun 2024 10:18:07 -0700, Elliot Berman wrote:
> PSCI reboot mode will map a mode name to multiple magic values instead
> of just one. Convert the mode-.* property to an array. Users of the
> reboot-mode schema will need to specify the maxItems of the mode-.*
> properties. Existing users will all be 1.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml         | 4 ++++
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml        | 7 +++++++
>  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml     | 4 ++--
>  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml        | 4 ++++
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


