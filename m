Return-Path: <linux-pm+bounces-20006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5DA03D57
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCB21881289
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C91E9B22;
	Tue,  7 Jan 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1Od+lea"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAD1E7640
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248343; cv=none; b=PyqJKha2BdweA4cFBuLVcgLY3UGb0h/tQpD7giGIePhibofETRIJKahQUCG8cEUNPC//BzeKAXW50h6p+SqBi732591mBwm4MlMh06vhASaTvIfKklnJymffc6d4S71e1mWbcIegdVwYnWDU99pfUmmDkP6wOCfCZoakIyS8QAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248343; c=relaxed/simple;
	bh=joH8dqPFxMW8rMz1XO77xmtl/YHd4CcIpAtUzKZocZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9lIjcP777O/7Fw2zA9wSSmWZiAR03BML0CZXv+jicQl+Zg8kESpCLerI8Z9fBhtssfEaQcsq44PfxhviXg6QuZn5l1CoOztJ/STng0QNDstIJ1RzOIpuJ5BVF9SvmovWPKZUQ2NTYWETOUr0dvMkVV3nq2wv0qqWRGUYBILkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m1Od+lea; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436345cc17bso111278345e9.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248338; x=1736853138; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=joH8dqPFxMW8rMz1XO77xmtl/YHd4CcIpAtUzKZocZE=;
        b=m1Od+leakSH+9UPe0na25nBiqlRcB80xbGTSr3s+cK1aLe+SH26x0S/HyEs3zL3PY1
         HSg5qPR7zKnJ3BMGxdKSZ5YD7LpZAuqWt7boKrn5xv+85VpfJFVauJQ7KvDfC9vBYKVy
         kcFC3mkI1s5kO97yFWLc1eNITLfuC+BQfFiN10KOgJ7xxGOuwrF6GggwqNWrbqC/hsn1
         a5xbDwMhmpvWUCUIBDu3tbNeQeyJMyvPYRV69w9WKCTh+KNyJJlLTVYcj+EKBUX4IDd1
         t6kwnIGm+Tongc4pRoOG6oqOKaBpdtNfLNoNNHTYyK7SpmrIWnOCw6m8JkjFXghhjEiC
         SZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248338; x=1736853138;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joH8dqPFxMW8rMz1XO77xmtl/YHd4CcIpAtUzKZocZE=;
        b=Se8UGtxGjsSStJM9LdZupFWFeZbxcfiEDkGkdQwbsSa/AEx+IzYeidt5H9RDfmE1aY
         jRb5lHujPIFMG/T9tzrG7w1Y1cNYsjcuNQbx33K+MPLyG5kvniH7FtMDYInBBsGRpoVd
         E6Gw8Ot5LZgayUsjWF85A2c1RFaEcDe1GoA+izfkRw38BicOJ7kL9Ha+cpAsA1RTl8ko
         ijhOAPL/lWMml6GPnR3SJOgy3Ipz5RZvrFkp1//fQyp7NuUsYSD1Ag8KsnX1BIDR5QV8
         jmvsLJiG7NN6hPBPPKBfDbF+KbILenzfOmv2dLtr6jVb/I7BYFG0DxCVUu/KjZQneYea
         wPIg==
X-Gm-Message-State: AOJu0Yy4NQ81HeoUT6uXu39Bvzq0Ux6VuxdLPRrbt4mEBLH7W+c/IICs
	2OyBVJpgw8HeH1VUBF4c+nJ8xUIjPWdJbf4nkJrNZXVOHarjRPHetRZsp0lGEV0=
X-Gm-Gg: ASbGncsCqaGo0fiEJIX4S1CILmvhKjfx/7bRW++ijxTF0bDtFDBEZjiSJUNJxzCTfRj
	6iOcrFLpcwdoqRLUXlwlfFARkTYA5ICvA1tfobU7Bg4L1Q8eueVrFczlIXvPuF0FC0AURrMY+GG
	UowG9oWAr377a7Wz0VcBbUJ1RWkxZf0BeFhAVQNLXjo9ceIomwypZ/D6guWx1Gy23mPWrLx3Pux
	ERjytsBDxGPHD7SKJGoGPqR1rMFyMknUVj1Mh8nRoI3AEEhYzhV96mePeqT
X-Google-Smtp-Source: AGHT+IFpD683L/Xnq8uxEeqg9tsz3tz8lKlVXMa5R3Jx59Gslqaq2nNppeiA2Jql4f+qmKUXncptVw==
X-Received: by 2002:a05:600c:474d:b0:434:f623:9ff3 with SMTP id 5b1f17b1804b1-4366864616amr567908985e9.15.1736248338172;
        Tue, 07 Jan 2025 03:12:18 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847dabsm49540541f8f.59.2025.01.07.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:12:17 -0800 (PST)
Message-ID: <9bc7e48b51d056acbba83bb40dfe133b16decc44.camel@linaro.org>
Subject: Re: [PATCH v2 3/4] arm64: defconfig: enable Maxim max1720x driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Date: Tue, 07 Jan 2025 11:12:16 +0000
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-3-87959abeb7ff@uclouvain.be>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
	 <20250102-b4-gs101_max77759_fg-v2-3-87959abeb7ff@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-02 at 12:15 +0100, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> Enable the Maxim max1720x as it is used by the gs101-oriole
> (Google Pixel 6) board.
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


