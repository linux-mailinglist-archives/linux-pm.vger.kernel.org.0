Return-Path: <linux-pm+bounces-22689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B2A3FE91
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 19:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BB517E106
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39029250BE5;
	Fri, 21 Feb 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbH61J8L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE841FC0FF;
	Fri, 21 Feb 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161872; cv=none; b=k3/9RFGU2BMOF1+aJb6I2ut8bRosOCjV0fDL6x3L7rH7d0Hk3Lq953Ov0ANqZ7d5gJPC1SxMqpnaPKvWdXy8DIPPCk6fij4oISemyEfQWY8xIzePS6gPeAmUbbO5zdsmFOT52L3Os0oLFw5b3/ZnA56pLsHgGTpleuUnkOjwth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161872; c=relaxed/simple;
	bh=U1W17n2j1LxEWs4Y4W56XmMTe4fnObSaTHj7aF3YLUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3shLX8UjNHvFNlM61bJo7D9s9vswha7ZQ9WgQZPILN3yVw0cfA1p2Oaj/17GG/7evK8izB8Eu3YO2wV481kuMDpaZE8PWQoJkZnTRfmDsI6a5LXxlDU2nX6X8jgN9ZGhOdwA9cmL/4dEwgEvrbra65dP4eHKS0xVZcHAZ85vF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbH61J8L; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so2018423f8f.2;
        Fri, 21 Feb 2025 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740161869; x=1740766669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1W17n2j1LxEWs4Y4W56XmMTe4fnObSaTHj7aF3YLUY=;
        b=SbH61J8LUiRWx3DdZ5apqvjgfZF8EGsu2l4XHq7Ii3NZ7gcb+isiTjaIaSXUghgX9k
         pIYL37agjMO1PG/oSxmLQ63gjERympyyMuHWKxbbzLgTjSYV8mn6jQkQ18jDpSncKN7i
         A8gw+61QSQh6wgLKwlBF/TcCdhlrI6N0irjYOEQ/Xt3WxZP3QebS0QtpEnJUfljLz9ZW
         8Jlux3vL2lrtYeBySCDz1lKuXCx0HbF7g9tPibx00TI2EWCFIWCMaGV6yPBUAFrUhva5
         yAiqK1zDrL8Ec0LVHUFlJFR27CwSp6Q+qV16JLkSzP8h7p/p41RA/C9mEBpZh6185eMv
         Qx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161869; x=1740766669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1W17n2j1LxEWs4Y4W56XmMTe4fnObSaTHj7aF3YLUY=;
        b=QyYDGiPdN8p6TjmZTY3g0HjwXyG+YW9NrOKgznqyX8WAjAzryx+Q7Kd+dB/zhd/gPA
         X1K7wi2HaX+cZgq+ZIcYi8kvXWY0ZrXBWLol5imPnd1adQ8ziA7TDqaM4mkYXcfpztct
         INJwKDyVBI85Dw33lo6TMReTMp6/i+ZpNEKNsC5sgQAsOa4RImIMtg0NzJnP0oF+0zaU
         3zTvFRUy1/YJ7IFFOKVsWhZ5WB4HU237I9AUwh1Vz3flaIRXdupIjVg070CZebLkHT2K
         PwmvKg66elMyQwBXlUfNhjWCUTViWYOzLrf+XEQZx8FvqJGO63YkV0L/MQaGs2W+W+Dh
         JiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbzoDlpwmk6HeiUEe5SEuUXndeEZwChRl2B3BeTgDVDV4jEm+PE+i7EBfeXbYPWxMjis17qdo8mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCk/loBJqHi60XF+OZD0o5+gottfXUoy0IMs42Pw3jDCoSkAf1
	HhLHyKJkxd2KfHt/9KIdl56oEobwCpBflaK44OfMueximPdK3ncDoYTBJgBTV0I=
X-Gm-Gg: ASbGncs9wHDAlj0mOcgm9gq6ofXOsPLV2Mh+N/bJffwsEZsfMJyQE7oG925LX6yA8x/
	90l+qXCoNfLp/XuXc1eMnih0tqVP7EEi6KRi+fUR6Yfih0xT9wjTJHGKcQk9Tc2y8Zk9hVWQyTi
	aoCmt1enXiuDiFLO4jpPDXAQm3TLjq/R9z4vd4yfmB1UUAwSvwgFJRhzupHZ/vAcRHR/NtH2cYk
	d340HjgwQQuuGbA9mtaOEZea1d/bCNRTl5ZeeYz/odOoMJpa3h2C7HhLtYwmYnri5R1QllpcnqJ
	6+2gkIq5daBcY/jVZU/qD+B98VDUFPHSGsWwvCUjhi1f1+ome55g+Oc1o5WSapiU0j6f77K78AI
	U/Q==
X-Google-Smtp-Source: AGHT+IGALAtK0qhzwHjSpW0g95HnjvEvJPGyQ0Ey4mOVtgunT7qzZCNsspeeesB5+gBG16CVVLhPtQ==
X-Received: by 2002:a5d:6c69:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-38f6eb6e4bamr4302293f8f.25.1740161868722;
        Fri, 21 Feb 2025 10:17:48 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02e425esm24683075e9.17.2025.02.21.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:17:48 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, lee@kernel.org,
 samuel@sholland.org, wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, sre@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject:
 Re: [PATCH V2 4/4] arm64: dts: allwinner: rg35xx: Add no-thermistor property
 for battery
Date: Fri, 21 Feb 2025 19:17:47 +0100
Message-ID: <3335250.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20250204155835.161973-5-macroalpha82@gmail.com>
References:
 <20250204155835.161973-1-macroalpha82@gmail.com>
 <20250204155835.161973-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 4. februar 2025 ob 16:58:34 Srednjeevropski standardni =C4=8Das =
je Chris Morgan napisal(a):
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add the property of x-powers,no-thermistor for the battery of the
> Anbernic RG35XX series of H700 devices.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




