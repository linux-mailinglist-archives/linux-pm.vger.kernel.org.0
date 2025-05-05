Return-Path: <linux-pm+bounces-26665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317D5AA9BF3
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EFA17D00A
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725F026E161;
	Mon,  5 May 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQwiSl8y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456519CC22;
	Mon,  5 May 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471051; cv=none; b=T4qFaQPh201748CW/8pJDHVGld/c/N0GR7oGPFsKB7hk4gqQhHa1QmCjvyFE3Fne5ZAlf3C6NmYKrFX2B4BA7HWqxr7jnCO9t5GcJsLOcm5v9RM1fH34bTHcPaauv9RMaQfZnszhZXVFOCNGAJJ803fWhzz1Z9Y4+mZ871L476Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471051; c=relaxed/simple;
	bh=FA4ZXprxacKTvK0sy51tKZPsTbcahyHK/OPJJTKQBv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eO5Q1qnaxtT7bGXX3Y6vRNdNo400l3B/Z52sqh8wVVJsoIORUQGz31R8mxP3KFKDkTocbG5ynZQeW2pVNiivWNNC3uSWhp73uQwQ/PW1f48fnVa7i0WWLTIaF6TcYWWpqfRpNQzb/y4CSW3SOrHhNGbJwk2obr7FSur0cCQErHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQwiSl8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF37C4AF09;
	Mon,  5 May 2025 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471050;
	bh=FA4ZXprxacKTvK0sy51tKZPsTbcahyHK/OPJJTKQBv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fQwiSl8yPfxn8/ca/CPr/ykouT9Z/FOv4FUQbqLBYldb5O2OF2M2++6fe+tcdjRQ1
	 2/I6oGeGI+AfdRqvXqhkYhv3uvcDNLsrHhv8tes2oPKkwz8TasWJcrfRylI8ljImnj
	 UwkceDOA1cS9FqWAEKW6TfbjKrj/xWCgbUMl+bvxZNMkf/wLW2A+dRgN4Wp1TA9xY2
	 2rRX47nOq80/SDBm7EWokT9Z2XCEM9ExSZHVwgrAjuGF5TJWniQry1k7abfbrj5+XP
	 Y833/5bCGl52uWSVZ/K4IHj1IaAR7KJs/e9JvZ4i4c4MfrDCb3wwtJ/ywUg6keobTJ
	 dRsVMYhRRuKag==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ace3b03c043so732464366b.2;
        Mon, 05 May 2025 11:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFVv/6sYXx4mW24UK/wWoXYJNvj8Wk+IF3HbF6fE1Rv0um78SWgPK4UFOCmNFJBJ33IeN/sN2oXo5oNXJt@vger.kernel.org, AJvYcCVVK5D6ihmQeR0Ovrv/M5km7iDf82OziKAkeRAzccWoLpxVRlNy2wMExFFfgtL8Og6jxUM4qRuEaraMvQ==@vger.kernel.org, AJvYcCWDHOcmPgNWbvqFzBgztCRoBUYwj8DwtNCUskpQpTkIgs9fQX1JiNMfnenTOlN5wIcnh80xeyqKQxsuD2Qc@vger.kernel.org, AJvYcCX0MMqTzY3iS9Q5yox84MCyIBguGGupFnuXAgWqu2HE3leT8GNeLMR3d0ce6OxT8NsPGeQOhgLgJnmM1b+t61fZuZY=@vger.kernel.org, AJvYcCXHcdFY3Rkq/z3l22Tf+sPEWFyZOV587EWYlFY4ef1p1fVk90i6mL2DB4iDRtvqYlFVpqlpV/KDf8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/+gyEbXw5PLdq9IE8b+n4DyVhPDVNlzUiUPmsPjq2DqKIkyp
	N61VFOTFb4SCdpKd2bjX2dzEpCFsPXLC60B6bYIGwhbNJ+JPxvMHvKwE1w5zh/71yykLFH4KkUp
	5atf5eGfBSKpF3JG/RKacXZP0GQ==
X-Google-Smtp-Source: AGHT+IG+4wrvsmSUA4NXOeBgCVpJAWp31zQ7/foCm/dgAap8A9CGCQ6aZw7m2OsHPJAn0nsZq/ZG84HLBSB1XnJ9F4M=
X-Received: by 2002:a17:907:c292:b0:ac3:446d:142 with SMTP id
 a640c23a62f3a-ad1d450c0e6mr10543166b.2.1746471049255; Mon, 05 May 2025
 11:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
 <20250410-dt-cpu-schema-v2-11-63d7dc9ddd0a@kernel.org> <CAL_JsqLGHQ4YBqGGEdyirtgaBnJKRxOxOKTaQLv2jm-g8TNndA@mail.gmail.com>
In-Reply-To: <CAL_JsqLGHQ4YBqGGEdyirtgaBnJKRxOxOKTaQLv2jm-g8TNndA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 May 2025 13:50:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKr8784O_-p6=EUqTxkVe1JkS8O+KWEfpVoWvy5NYC8DA@mail.gmail.com>
X-Gm-Features: ATxdqUFAJ69lA35S_IWYAUkz4lOUbb3QiPXOkddsmyihxhIW1B6e-CR89pk_81I
Message-ID: <CAL_JsqKr8784O_-p6=EUqTxkVe1JkS8O+KWEfpVoWvy5NYC8DA@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] arm64: dts: amlogic: Drop redundant CPU "clock-latency"
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	UNGLinuxDriver@microchip.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 1:43=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Apr 10, 2025 at 10:50=E2=80=AFAM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> >
> > The "clock-latency" property is part of the deprecated opp-v1 binding
> > and is redundant if the opp-v2 table has equal or larger values in any
> > "clock-latency-ns". Add any missing "clock-latency-ns" properties and
> > remove "clock-latency".
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
>
> Ping!

NM, I see it now in linux-next.

