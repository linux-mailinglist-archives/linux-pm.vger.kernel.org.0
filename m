Return-Path: <linux-pm+bounces-31401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB62B111B0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9875866F8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0212ED15C;
	Thu, 24 Jul 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIjyTaKn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C42ECD3E;
	Thu, 24 Jul 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385341; cv=none; b=L5LZUwmkWiovRnIwaY0I3xAP/nPKnuKNpSHL/G7FK9MF8Nt9laRbRzthqn8WA2C2w1TcKKIdXNCwekXky7WbyUjiQdZZ2A+//ZsCJzFs3WnXjdDB4ZATkXz+dLA8Le628aUgLCMoJ4JIq7DVXLiltAkRERbF8XYBo8PEeRMLCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385341; c=relaxed/simple;
	bh=LhTJm0/lGmmaCK91nWxTC3cAo1Whxsr2o2C2BU6YW5w=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Y+4itHcJlgaYWpsQkwo7Zkal8/k+qTspnHa2BWPhVinpvfo7LKk3SQNMlOgxMW+A8ELjGTJrlQ8RAl9z+d3WAEqbJFDVrhKS5hCYb84ohxsJMj9aP5Bx4rUdktIE+vB8KKdzLWtzPZg3S7/XPAnKqZOpws39hyZgp88wgb35dW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIjyTaKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16425C4CEED;
	Thu, 24 Jul 2025 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385341;
	bh=LhTJm0/lGmmaCK91nWxTC3cAo1Whxsr2o2C2BU6YW5w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jIjyTaKn+xdcguz7TbJJlbdOLTrNbVaW4d0vj9sq0ao6zX8U+zU07fV2wzp4e+RN6
	 CLKhoKTc087WqRUGb41kOnbgdtyDpeA6uELR4rq1/eGYzEbbIzEMWhbDGEDCo209vF
	 XWrRh0sp5621iIY2H65hgPJmItmdDCjLKLOcxWY/1zQOMJFecERPzx4AJ+0qwF5i+F
	 jWvcH+IK9aSzbT+IcXkJpDg+2yumt7z5sgElzvbuktLAxmsg1uOW104icblr+GBAnI
	 QP8BttSzeZnQ0Yo2rOIU1Kc1x1Tva4a3rSiq3X8zjHYK1Bxmo/uUKU7T2JKKzV+SWB
	 qlQ0bSat2jVHQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <175338519842.3513.7440958226312827195@lazor>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com> <20250717-bindings-double-colon-v1-3-c04abc180fcd@fairphone.com> <175338519842.3513.7440958226312827195@lazor>
Subject: Re: [PATCH 3/3] dt-bindings: soc: qcom,rpmh-rsc: Remove double colon from description
From: Stephen Boyd <sboyd@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
To: Abel Vesa <abel.vesa@linaro.org>, Ajit Pandey <quic_ajipan@quicinc.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Danila Tikhonov <danila@jiaxyga.com>, David Wronek <david@mainlining.org>, Dmitry Baryshkov <lumag@kernel.org>, Georgi Djakov <djakov@kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>, Iskren Chernev <me@iskren.info>, Jens Reidel <adrian@travitia.xyz>, Jonathan Marek <jonathan@marek.ca>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Manivannan Sadhasivam <mani@kernel.org>, Martin Botka <martin.botka@somainline.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Priya Kakitapalli <quic_skakitap@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, Rob Herring <robh@kernel.org>, Robert Marko <robert.markoo@sartura.h
 r>, Shawn Guo <shawn.guo@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, Vinod Koul <vkoul@kernel.org>, krishna Lanka <quic_vamslank@quicinc.com>
Date: Thu, 24 Jul 2025 12:29:00 -0700
Message-ID: <175338534025.3513.8075934399591002683@lazor>
User-Agent: alot/0.11

Quoting Stephen Boyd (2025-07-24 12:26:38)
> Quoting Luca Weiss (2025-07-16 23:54:46)
> > No double colon is necessary in the description. Fix it.
> >=20
> > Reported-by: Rob Herring <robh@kernel.org>
> > Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kern=
el.org/
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
>=20
> Applied to clk-next

Err scratch that.

