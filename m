Return-Path: <linux-pm+bounces-25295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB2A86712
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 22:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEB54617F0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAD28CF4A;
	Fri, 11 Apr 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esDdo68Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C5280CD5;
	Fri, 11 Apr 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403224; cv=none; b=KnJG7QH8GOL8Osktcul49ZIDUW9P4qHZnjEZIpKzxI86yG1Q2tnVo4xfo9zYbgW0ZlGpnf/eiwItDQ9daqnETQAPhqB4DaHgmCALbz5xqjGAsuyJiXmz1JIRwEf3uM2jMPwKrm8szFkexIc0RBBEXMfmURMf/NlsGYtTQrejUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403224; c=relaxed/simple;
	bh=0db2ZvvEaBiYWW5dZn01u/FW+dk6clupic3ccg4s29U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWv/GVNR7ICMiJ5IYQ6k3L94cN07QxKTG6+DwGXNezJR+PTrPD2AMNoU+QHeoVRJFozlV8plHZePu0wKzVTcG+Df6t/yXG79g9FesGDHg/jXAdrTPyar7g74jM3g56frYJfoNAQ1XIa9wqc8gAh2dA/MFFmbjf2LVcLk06v4Bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esDdo68Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8576FC4AF0C;
	Fri, 11 Apr 2025 20:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744403223;
	bh=0db2ZvvEaBiYWW5dZn01u/FW+dk6clupic3ccg4s29U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=esDdo68Z+d4Hv2xTg9bir7moDVY9WA5ZHNQOQQSuaSqpK4ZVZ5TYCII/bn4RwxMZr
	 v91Fy4ZOoM0+/Jt/kJz+hHTDBH5Y7cgorkg7hKJYfMEaAtyYm0yo7TVsyLDYP8X8Yr
	 lbBolizfkYoMybinoxMnQeO4z15ssNsGWjbJWaCNcXXhLeL8+wXdXh4bxQDVNpBy+W
	 16U0UR3T/W7DwHyxqusjQCSezbEnBHt3oAODHEOXBlDZ57rr7uw2sGTGNNSPwztmgs
	 OP7R18BP7Fw67uyJpytSsPPFA8F8LJPW2roAjchwrwdUeX0R1tYzq+HQy0G41GmtXm
	 oaWZ2H87kVc8g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so3628596a12.0;
        Fri, 11 Apr 2025 13:27:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURY8YPXJKPKQ1pCXmhlHuc5IAYZfj1TfKJpvjNY6HSL3ax2ixUJJZCoAhL37++9cG47+xtxLgIMcCkpbiA@vger.kernel.org, AJvYcCV5wxCbtCqAJKeBoUkd/upyOwGDuqoR1Pv8OTTh4tn1XD8yqcZ7de6TIDwyLMIPkSKf2nhsQd1E6LvR@vger.kernel.org, AJvYcCVOch0a521vxYakr66CzacDo60E1QMp/TaZjSiRfaSuOEfQe7/lnIBD6IISd8BtwWgxSWk6/PRQwbGlSkHKwQ==@vger.kernel.org, AJvYcCVphpMmdlzM0qQSJEV7V/BUW3/gtrt0NdKybT+c3DJVpzGy97p/TZwqsDvpcqSLUo4XUJzGbrgc02o=@vger.kernel.org, AJvYcCWEFNQu08/CgdnoAa05IneO6qdIOxCat5akNcGtp8dYImNTDH+6vI3KuwhoNdIbtEp5UCmmwnuUhYoKew==@vger.kernel.org, AJvYcCWFIvgTFC/N2UwxviTuFc5LJOfa4DTXBQwAD2bliQlZXAMRCrGKF9NYoIl6iFJcwAUtIqn2/EF0/VnQq2uELJl7Qv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uyL3HhsiU8vVC6d167kCu0300PF0ALumRMOwG+ml9/wG37wB
	PYX5mu4JuO/t+vQ9yXPaL19fpVOaYTx6RFYnn0R4VP9+6qlhu6PNlXVz0zE0eZU0TISC8hGwIRv
	PV1u9v4GrgvyKmO2C97VUmpyqeA==
X-Google-Smtp-Source: AGHT+IHTq9IynIF/z4Ryd9XhwviquzTS623VvUxbOB2plMDWlWmVxnnGmioMBYPRMrNx5/qrse/N9OEq7aX0hV7vQRQ=
X-Received: by 2002:a05:6402:1d54:b0:5e0:49e4:2180 with SMTP id
 4fb4d7f45d1cf-5f37001322cmr3235456a12.25.1744403222033; Fri, 11 Apr 2025
 13:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
 <20250410-dt-cpu-schema-v2-3-63d7dc9ddd0a@kernel.org> <20250411-ebay-exerciser-392c42daf5ba@spud>
In-Reply-To: <20250411-ebay-exerciser-392c42daf5ba@spud>
From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Apr 2025 15:26:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJza-bufzjZ415THyDDQaOfk8F+JRFvFxzNwObG=NKVJQ@mail.gmail.com>
X-Gm-Features: ATxdqUHjYgk-N2yFwfhKqPvFMPb1Jj4TAQ2QQ1AYg4EXz2sFdyWD0eKD2bEivlI
Message-ID: <CAL_JsqJza-bufzjZ415THyDDQaOfk8F+JRFvFxzNwObG=NKVJQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] arm64: dts: microchip: sparx5: Fix CPU node
 "enable-method" property dependencies
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:22=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Apr 10, 2025 at 10:47:24AM -0500, Rob Herring (Arm) wrote:
> > The "spin-table" enable-method requires "cpu-release-addr" property,
> > so add a dummy entry. It is assumed the bootloader will fill in the
> > correct values.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> > Tested-by: Daniel Machon <daniel.machon@microchip.com>
>
> This is already applied, guess I forgot to merge it into the branch that
> appears in linux next. I'll do that now..

Sometimes I check next, but in this case I just looked at replies for
which there were none. I dislike submitting dts changes because it's a
range of AWOL maintainers, only applying around some rcN (so up to 2
months later), silently applying, and applied but never in linux-next
(until in soc tree).

Rob

