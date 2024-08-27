Return-Path: <linux-pm+bounces-12948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A819796062C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA76A1C21DEC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D905819B3EE;
	Tue, 27 Aug 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2tAqQVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A71145A07;
	Tue, 27 Aug 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752118; cv=none; b=pYODohtxtdXQa09KVLJ4pfUvwKcXjfq7O8Wuc1ZBHWZSlCxfxYQhLEp41Tbi1uIaBQjwkXGKOP3oA3iyYMh/QNiO4YZSPSMIosxIG64Fx/cEqfG4OYtfrT9CCNKrWeuRtu+dZoneK2R3HnC0HNE24jRjnofLELM3lOdvmIr2rMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752118; c=relaxed/simple;
	bh=Lej6CAf6PPRt3VxOUgFXQ/Kh7FjIH2oWJQXtjqr3t1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgPlkkW2uUGv6IeLxytamejwhK86+6C24Yl7Hn/6JhVaaXZX+LICTB8Wt3+rXOwjN7eNcvwd4k+XDdHlG4k30AN+bwV9vYYnrhU1SYE+0IU+3NtK9gHNoChoT8kVSiXluovjxRKkHeVucRDEhBtO3uUL+LhP+CT9U/kHRs9opRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2tAqQVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9651CC8B7A0;
	Tue, 27 Aug 2024 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724752118;
	bh=Lej6CAf6PPRt3VxOUgFXQ/Kh7FjIH2oWJQXtjqr3t1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W2tAqQVww/ncWjs8QD7oT3mEnmkczaF1jlfTUQpg9hajnJGo9DROxdfGCco4Avq3H
	 O+z4VfIpohiu7vzbmZyl/u/M0KvabT3bK+nVA2QW7ObfVdMTO6W/5pd/hJUeUiL3zG
	 1q3oSla6Z1CzJK3BjZ7mHw40dzIfJ3Hm15r7MvjeQceh4qAQE3D6UvMOEk0K4xOJou
	 ySrsVlqC8kExStgBpoHQfeJnkmsCZyPNPMVX3nU0TMU7EeJS3JWKDsPhzKHMkzc8hL
	 LS+c1uNuz1GJw8rWyZ8NL1vb2tbFxOY7gz3xv0cJukFjzLn+xvtmLCeJpXxicLnfHP
	 us6xLPdG+azqg==
Message-ID: <13101b4a-4158-4df1-9807-43fbbc11bf27@kernel.org>
Date: Tue, 27 Aug 2024 11:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pmdomain: qcom: rpmhpd: Simplify locking with
 guard()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org>
 <20240823-cleanup-h-guard-pm-domain-v1-7-8320722eaf39@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-7-8320722eaf39@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.08.2024 2:51 PM, Krzysztof Kozlowski wrote:
> Simplify error handling (less gotos) over locks with guard().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad

