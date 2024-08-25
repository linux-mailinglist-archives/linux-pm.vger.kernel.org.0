Return-Path: <linux-pm+bounces-12866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE49895E4BC
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 20:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CE21C20991
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4616C6AB;
	Sun, 25 Aug 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Rh8yo5Wz"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FF4778C;
	Sun, 25 Aug 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724611897; cv=none; b=Py93Lwxq7P+doDgK5Supa9nW4eL4XYlv6HsI3Dmanv2BFSKM+RNKYCDmus3T9CdKVPhnpzuvWTBn57Z3oOKS6yp4dktsmbiIURxSOVrY+q7PqwsKaWQ9yL2WlrcNkOH70ujNdkgQSvnGRuk+c/qNVogv127jLePmkzvXdm+CqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724611897; c=relaxed/simple;
	bh=5cTbhky7YFrpL+RevDm6rybDE7zSEzYgqdVDOFzKi5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvyZvfQc6+SpASmHaIHgmiQcCznjjVAdJ3VDyvEfcvXF1FoP9sUBjoWNoXD+c6b03IWGkSwqTo7j22LKrHLQrgQQiJs9TUdpCZYDV7WI8Do/E1wGqdR4KyTj9f17uw1Y8I6hiK8rBh4zRUSgc6bkHQ61F/9ELXBAnW3APgGFH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Rh8yo5Wz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Tf919g5pjHDA2tr82ZwJYUnCMczwQw53R+x8hlGhrU=; b=Rh8yo5WzRO2pcALV+TShKqmqFx
	EedVbP0R9DH0In+YtURIyzpiD52JJMuDYBQU5//E1DSsZC8GYnmvnF+Jr+FD6wMunFwJt42jAxqmv
	L5l2fl5Q3FA+HtSF+MtYZYZ8oQEJQdKw0GZr3mMxzge02BEoh0I0CHaG7PwSQ1OpQ5bBJ9ZLK1irS
	i9HuiMGGL1KdIlnYljPzN6v1zjaBt0F6O0swGnbE29yzxry+kCPySX30DKkx2noxuyNT7teJwEmbE
	EFOc6FTIUCOGngDtHrP8rnxL/4jwa/FhhikgUd2LKEEWNTavaZzp59wavuSGy19h3PLZsKReJEO7M
	5bp096oQ==;
Received: from i53875a40.versanet.de ([83.135.90.64] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1siIKj-00019f-9Y; Sun, 25 Aug 2024 20:51:25 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] pmdomain: rockchip: Simplify dropping OF node reference
Date: Sun, 25 Aug 2024 20:52:20 +0200
Message-ID: <1931675.GKX7oQKdZx@diego>
In-Reply-To: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
References: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Sonntag, 25. August 2024, 20:31:16 CEST schrieb Krzysztof Kozlowski:
> Drop OF node reference immediately after using it in
> syscon_node_to_regmap(), which is both simpler and typical/expected
> code pattern.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



