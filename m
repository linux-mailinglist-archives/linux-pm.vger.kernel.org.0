Return-Path: <linux-pm+bounces-32954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACADB33062
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B81189DDFC
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7E2DEA7B;
	Sun, 24 Aug 2025 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kmyhqCod"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348642DE6E9
	for <linux-pm@vger.kernel.org>; Sun, 24 Aug 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045453; cv=none; b=A7q4iD+8zvSiC8IPSPXQEP38fMXbEHW+ttodJdQlaBjFPP/OpA9O51BAwDBksq23xhsnitxIXWcb1yQQsobjr8NdEdq9yhFpxlJE4X6LkHjQ5Z2MGGtGqKrLGjAwkYNJN2Qrcup7Yq05DpuOylSM8SdiMDoBOuYwSSAaaV1g+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045453; c=relaxed/simple;
	bh=c3AcTuha+KxfjbXnXT8SmXB8RGUI1YZFmW2b/4MBe7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2pfPqLEyq812NRGZhdE5GPdp2owF5mCEsC2qc6unUn63syG99o16FAN06IJyc4n4sn6SdG4szwV5thJ4bWXSxtpg3N0puFGHMJ0okloGM1HxMg6gs7tPFsh0UMjZwnszspiaRnBiMSycTrbfKn2Yxyv4R3B+f0QTIMN9pTkwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kmyhqCod; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 91E971A0C47;
	Sun, 24 Aug 2025 14:24:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 699C8605F1;
	Sun, 24 Aug 2025 14:24:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49C1C1C22D917;
	Sun, 24 Aug 2025 16:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756045449; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c3AcTuha+KxfjbXnXT8SmXB8RGUI1YZFmW2b/4MBe7U=;
	b=kmyhqCod8sx8mGMTZdGYONddj7mpK2JlIiloqBpwHP1Tb8fLE/iwWQyvTdZei3uJxkKxEX
	20kBeFVxmoWK0FQL6takcW12uQjkJMmN57hCsjebW0BkMyp2Pkwt027S4wqpxFPzW/XCN3
	5KfmsKXmj9c0fkKGcMXE9Tl8KKdZ2tJdZE+OtnwY7LSUozjXt7kn3hG4DYXZxcV9BXc86f
	F1noAQQYMK82WGChWF1VswRpGbuLeajpltIy9vY3xLETy+9G1PQ165inP71MlM4R1bZMFx
	PjI9yWP7g09sQciegkr3OHEQsYvMu3Kblfl1c/r4p+WsM5gLD0yi2BIR5elpfA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz
 Luba <lukasz.luba@arm.com>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  linux-pm@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: Convert
 marvell,armada370-thermal to DT schema
In-Reply-To: <20250822225645.766397-1-robh@kernel.org> (Rob Herring's message
	of "Fri, 22 Aug 2025 17:56:44 -0500")
References: <20250822225645.766397-1-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 16:24:07 +0200
Message-ID: <87a53on6go.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 22/08/2025 at 17:56:44 -05, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> Convert the Marvell Armada 3xx/XP thermal binding to schema.
>
> Drop the AP80x and CP110 as they have long been deprecated and have
> been replaced by a new binding.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

