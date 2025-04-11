Return-Path: <linux-pm+bounces-25207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B12A856C2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 10:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052CD8A276F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E550293B79;
	Fri, 11 Apr 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dy+fjYOl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63827E1CD
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360679; cv=none; b=F/DIubkL/511+Xrdbur/HiXYMIssH82ORYyojVtI135hGUlgrwwJgZ35N5fBvVT7Yv54r2Y7mAXhI6t/Z26fKFHI3MugMEF9LVkJgfsSua3WS9f7Fkl8snO4JhYDoVHGp1dOGbiXVIqWagqBGB4Nm5IdgtWdmFNGB1O1BV+5p0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360679; c=relaxed/simple;
	bh=5kt3MWtin3KNwdzDbJU//7Uxuz+S1QGZ/maTZ/hrbSs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nj+77t+wqY5h+h48gM9eoQbxC5OC9fnGtOaQuVvrKG+MMf4mC5ZMF6okEenNavTSTwYEHyjlUd32YOG3PZANlGpZVfA8qSRbrBDoq1rfdMVb0rYq7mF2oxAC+2OWChdSesyNMerl29Ws3+5aeToTqVUET6JAqRktM/dg3ghyypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dy+fjYOl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so12793115e9.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744360674; x=1744965474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH2ZPuzfR/sU9gtELQf1xx9ouW+DErODBwUT5LwG1mM=;
        b=dy+fjYOl2NWtqXJHHd4H+Tpo9L+/m3lsuYvwRfy7cD+16NN+q8tvv5gyAlQ0ra23IO
         0C98gB9Qk4qsQXQfsD3sRaiVfwIoa64x0I/ZKzJsNADmHD9OfLWgy7apo4hEn2PEWWg9
         zJ/s2Ceme8nWBZ4R6ljHMBWREuI5HZqI/Z00u20fltn6RwNN64mweBGMGSThN4Goureo
         aSwEoq15ptQnQZ6pwArHiL4cz9QwxQbPuYz2J1dg+V8q4Cgt8bPcj20M7gH7pGlbSbVU
         /olenrBVqU5Smru3g91jmBiFa9msCGO+1nblQGmsJKojRvQLNUorj7flEXND1KBhwNJT
         S46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360674; x=1744965474;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH2ZPuzfR/sU9gtELQf1xx9ouW+DErODBwUT5LwG1mM=;
        b=hEj8jrOnThgN+3qAiQfu7XnO3KXvMkn+uEFXeqz1MET/z9mH8titQ9WJPgFd/Fae50
         pc302r+Gr8crVw34rgnNVCSaeHMoW39ZOSZn/itZ/LbfzyvnreyRo+wx3SsNth8OIP+D
         jN4h+eF1ULZuqlVg6vi8ecz8GcxuU38W2GmJ3sKaqOJjt+dB9rSLpZo9ALnsiE5ert4g
         PKtPB5dQHgK7DvI/N/8b+Jy6oSbZla0fb2pzfajJkxV/nrfwZ4umHR/puyaXcDMH59ed
         AhnHAqq5RYhQMb+7fSDdkY+Ch2hCg5T6FYRjp1g9+Zg1798wjxEll8z5P4t3GMO+SCIA
         /VmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOEH+5VnVFOSHDoz8qKSxFSn5wp34T0hHh76Enb3KEUEPbs0P7qC5qoSb6b/vGk244+OzFlQMWMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlEN7PiOBz8SW/3JDZnBwwEEqgCiUTxD40C1+54uV09/eQP1I
	E9DN2rBgZf586fJCd2SQQarMoLOr90C+7GckY7nyfSvlX2FRoLp1bb3K5NMwFHw=
X-Gm-Gg: ASbGnctC6TNj7rHJf8MaSz63G6UuREJLXPrAX0hQo7q02yxCyD0/KCKcZ13cAcwXe8U
	4H0kHsxqi2jAfbLZfbiL9Ycz7shLiq3Uuvi+T3GbAn1EvWk7PCwpEw39gTlv5nRMPqmQf9qGPRa
	OYCpfu9ivzrdvVdX9th1E4CV6+M9dJWZtWNbZtrJreVRtt6oKI9Lfn+jMIOG2mKUaLIIsAmVCV6
	wLBEdcjLPq52nP6DH8tCQNNLH71oyvt91G2Cjxd+t9ZeFbIOxrsZkpb9NFk1H+XLP6PMRyHRqTP
	vtDarJx05OZBccOF4xRZeXJuiz3SDDX7DV7DaC4JPLZpFZ/grrUs7nhj+qk71Q==
X-Google-Smtp-Source: AGHT+IESQEmfqjjVD+jC6dd63FDfAGrpItTMGFb0BJ+4OP4VGIDucBWUqxZDD69YlSOe5qeibdfp9g==
X-Received: by 2002:a05:6000:2c5:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-39ea51ecb8bmr1357243f8f.5.1744360673907;
        Fri, 11 Apr 2025 01:37:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9777a0sm1326282f8f.43.2025.04.11.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:37:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
In-Reply-To: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
Subject: Re: (subset) [PATCH v2 00/17] Arm cpu schema clean-ups
Message-Id: <174436067236.3436338.6767561918297500530.b4-ty@linaro.org>
Date: Fri, 11 Apr 2025 10:37:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Thu, 10 Apr 2025 10:47:21 -0500, Rob Herring (Arm) wrote:
> The Arm cpu.yaml schema fails to restrict allowed properties in 'cpu'
> nodes. The result, not surprisely, is a number of additional properties
> and errors in .dts files. This series resolves those issues.
> 
> There's still more properties in arm32 DTS files which I have not
> documented. Mostly yet more supply names and "fsl,soc-operating-points".
> What's a few more warnings on the 10000s of warnings...
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.16/arm64-dt)

[11/17] arm64: dts: amlogic: Drop redundant CPU "clock-latency"
        https://git.kernel.org/amlogic/c/4bc28af2da876531e5183d25ae807e608c816d18

These changes has been applied on the intermediate git tree [1].

The v6.16/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


