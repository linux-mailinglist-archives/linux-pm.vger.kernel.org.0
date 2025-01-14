Return-Path: <linux-pm+bounces-20407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF6AA10674
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 13:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF5A1884C22
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237D234D00;
	Tue, 14 Jan 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdHQrtqe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97020F998
	for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857038; cv=none; b=tSlwMHOZJBYeuTUATgo7Nzh1yTh9SZg0ktIy31YUOLTqCrJjdfcfNooeXOoaZk5HJLQSDzfGxXvvMDrj2SJUx3Qc24OnWQbwom5iFBUoW35n9IdycA6HMj/aGozfu+xoc8LRDNk7XFW8e8UP0D2WCuhR0ElsHYUnW8gf2TfMcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857038; c=relaxed/simple;
	bh=8Ie4b99Xwh0aEWRWBEX58b0bMixe8tSP3T+iPjUb6uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvxwxnaLgmspj63rob7e4/1orxV2eNOMA7nS1JR3hMfe9ivNkWMzY2RXwa+ps7ZSDUMFLNpubm1Ce1UolUgSjpq5vq98dYitWGi26HAQDPRUDe4CFNFBcnMUznKcfWmGHoaetzkWB+Ybg5nBqDiOJRlJT2V3qlSJvy5+4PGkMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdHQrtqe; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so4231355e87.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 04:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736857035; x=1737461835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ie4b99Xwh0aEWRWBEX58b0bMixe8tSP3T+iPjUb6uc=;
        b=qdHQrtqeqnAhe09KLETFGSkDMQv5jTwlECLYrdCpML+BDUAu4hv3V+dz2s/C/dTQm/
         qRrExopeKyFBXre2BxAocM+XqmLaXrOr07YAyA3ZfuqJAwaO66u8evVZHlTCb8xKNToO
         oX0yPj/t7D1IPRTc9zj2ymBwzwpDYx5f/C2OAGQRtVrmmgG5Oy/lkvFnQHDIMrSiEeOp
         G7rqcuTLmWDEI/aD2ABQdlC11DiJfjWMgZtZmhJny/LWeP+ODbTdNm5O7a9xc5KyyN+L
         c2Xo5Z6b07WciVrpxCXaR0eQwW5HymUGzIoLN1iG4E5NSaZ1uaoChd8j4w7xhx2MMmRY
         gcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736857035; x=1737461835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ie4b99Xwh0aEWRWBEX58b0bMixe8tSP3T+iPjUb6uc=;
        b=eTJNUHNwBntk/RRDvy8jcPlBfH6tjjdxbc3L8X8w4EDwitscUp+brK4Hyt/bvx9B7g
         C/PdHcIRc4eFse4q8GCpV7kduIVGjEpolpi+h3UTy1TE41Pr/kgJdqFUDkZC/zH8cdM+
         y1PaLXAzsfs/JMa8vCAABz+F5MQGbHyPubMk0ei9ewE4NqFPiUFFUbb5LCb0q3HBhD/Q
         3Fdw/X5b0cNlyr6KAG2pFv6fKj/JmerCkVwO8Bs05hQFM5Occ4IHys/BHM+RvoNTYY/E
         1DBChOcYg6gWyR+BQf79MofynSub8r6BI5RUbVBvpPDxv4FPYZKuwpNLpORtzPfFgwbK
         XlYA==
X-Forwarded-Encrypted: i=1; AJvYcCWOZAMhn5JIoMA8G6bd9XaBpwxjSMTnzqQt+PDXW756mLpRpyJu6pJSDf52m3T+pwFiuxbRAqE4Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGF8sw+F7iJxwL6m+WHzHAyBb+WvmQZSeq/YUErC4qgvDLodr
	dEEDj/0ViiBH2giiVoM9hu83i0XPw11cAXhULERFB+O3rRTRTCZOPZZ3raTb/jHpj0+XBCFR6Zq
	j+D/33OqGhiKoLC8sXjaATx12fXOe81XPTK92mg==
X-Gm-Gg: ASbGnctv69ny0DbT+9p2hia5+ILkYAMEoN23NuZgVoDiEhvyrwOtpga0hzJ0esZouCX
	kCyiukZXlhGmGLdwrCYFlcEmln5YE5ajsu3tZ
X-Google-Smtp-Source: AGHT+IG/nVzJ4usllSB7WeL3esJ0/+hz1rQx2YNWDFn17mueoKalfz6Uj0tzGOzfhZRqk49pDpDqslNG3Jdx7c4EaqI=
X-Received: by 2002:a05:6512:b97:b0:542:986b:de08 with SMTP id
 2adb3069b0e04-542986be0a1mr3961478e87.26.1736857034594; Tue, 14 Jan 2025
 04:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com> <20250103-wake_irq-v2-9-e3aeff5e9966@nxp.com>
In-Reply-To: <20250103-wake_irq-v2-9-e3aeff5e9966@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Jan 2025 13:17:03 +0100
X-Gm-Features: AbW1kvYSSgagqOIiggVP1rEX84eySXcyOvS8Yel1NcZ50o6oIQlw1NaD7KnQIZM
Message-ID: <CACRpkdbFtLhGXwSbCF+v54eEdm0w=sDsseUPiRfc=xmak-DbhQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] rtc: pm8xxx: Use devm_pm_set_wake_irq
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 9:42=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

