Return-Path: <linux-pm+bounces-32208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E656DB2193E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 01:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F8F190893A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC928003A;
	Mon, 11 Aug 2025 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay9sd5Xo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4F20FAA4;
	Mon, 11 Aug 2025 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954851; cv=none; b=UF8/VKaBwNHklgWbxiXsTXgErjCfQvZIiKzyGvG1fLpaSKbc32BNrJzCxWCXxkW7w1Fw9/XTEIxVezFrH6FlaVbrIjT/B540ihayJYt8O93pcdoBGjjZa30XdNm8NWO1e2CNJPLS/xbhrUkd8RzbYcMhFG98jffOyEbYBS407Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954851; c=relaxed/simple;
	bh=6yPyPa/6VABXX3mCsisBs6+EkiTsHKndMvRPv8Pn4D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3VsqhZ/Yl0waxJ7ICxA9boIM8an9cNIP1ajECKCYhFzXIKcyaL/bLFf5la2p3OToJkOgaJ1XqGeqj9knFYNOtrwmsg6lGnoMcruaw3JrAAJg2j80KvOnLstvrqzCGFoM5cU1TSfCn/SA7/p1ff4B3+GsUfVVuKfKYx9hafCdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay9sd5Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29640C4CEF6;
	Mon, 11 Aug 2025 23:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954850;
	bh=6yPyPa/6VABXX3mCsisBs6+EkiTsHKndMvRPv8Pn4D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ay9sd5XoJ+twG1J89m7Xi1nPexzaNbPNHDBcWBDajyjzrirR4kNn9TfiF5/h8rgd2
	 R3pBcbwMTM/AcF0NPxU5+grulSf5eAr+uBsNit6c8CtUPVbd7Jmt+hkBPzh1OXcLeK
	 2ZNeLi9yb7zktHcqbOY/0O1GWIF53fzZ7DKfPJtbfoKg0DjnOul51jMKCZxAJepNNz
	 WSoQUqLoEce1iptTXJw5YdIpF6cU6EL3g2mlfQwnm8hcRspaCwjt89L+rqcjB7+Plh
	 5/1qwHPdPfl8VbJpVznhK/OQHMs+IKbZ39yYl7kD5IT3cgzTileUMJ3nQCHl0YdAeg
	 SaAb7KAqY3y6w==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Marek <jonathan@marek.ca>,
	Martin Botka <martin.botka@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Robert Marko <robert.markoo@sartura.hr>,
	Shawn Guo <shawn.guo@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	krishna Lanka <quic_vamslank@quicinc.com>,
	Iskren Chernev <me@iskren.info>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	David Wronek <david@mainlining.org>,
	Jens Reidel <adrian@travitia.xyz>,
	Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Georgi Djakov <djakov@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Remove double colon from description in dt-bindings
Date: Mon, 11 Aug 2025 18:27:02 -0500
Message-ID: <175495482449.157244.9662741916220392763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Jul 2025 08:54:43 +0200, Luca Weiss wrote:
> As requested by Rob[0], remove the double colons found in various
> bindings with "See also:: ".
> 
> [0] https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel.org/
> 
> 

Applied, thanks!

[3/3] dt-bindings: soc: qcom,rpmh-rsc: Remove double colon from description
      commit: a6c4d92fcc74b4402d1ecdf6f4a7304a37a69ada

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

