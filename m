Return-Path: <linux-pm+bounces-25300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD8A8694A
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CCA9A6E01
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 23:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DE2BEC4A;
	Fri, 11 Apr 2025 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvvTsaXV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5CA2BE7CB;
	Fri, 11 Apr 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414632; cv=none; b=e/kqaCGAfsSUtuSYc2coW9oO6xnXpqzp9rVx8LpdGgnfmv6RW2go0m5Ju5FpEDY5RjrX9BJTGMs1D6a5J9Mu2819n3lLRPS4EkOKXIXq3+O9WhWGUf6Y/o0Z/8iisg7SByal6I0MSs7aJ9Mym59DuTLw5H/aOSpmmxGGBMOCZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414632; c=relaxed/simple;
	bh=b/3gzVMfgYxEZ77GHCaJmjb5ba9wNIawHHXzPE8U/VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSdK0XeMksMvwUly0wAciT5/1xAmx3UwPfytAJl//kDgrYa01nkxJUiHwrBheNYwnZIgYbb/3XHEWorMSMqOdIrQOJVzll9b8V39KylPOn8zfrcCVztgeAJLOE1FgOBwUAnftUDepS7v9YV76I3sENWj4WEE1sQNRdc5j0uvL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvvTsaXV; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72bbd3a3928so1472800a34.2;
        Fri, 11 Apr 2025 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744414630; x=1745019430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TKjBnAI0llRD88HQinqqWPzae0oerPBARTmSqosHWIk=;
        b=ZvvTsaXV4rplAtOS98F92pBQaXngjbUmnqXqmKq/Hx5JN2vj35GCDnum3o3XU5vp8t
         /9KmnC4btl+S+vJuyLDE+BY2SwsWArCm4b5iQ6YUFY9ni2Ejh+UmQGawSqaXQQpwoeTR
         q0dBMU9OB/jwCi/NZcTI+JsEvDV5R5vcdLi2mcxRwo7wZKWMsCadb3eGPU3prBrbMSpR
         7OZ/UP+XoLmI/a7t3dhx45K8RbBZfLPUCtckQv8DxkaTcxqpn9nAftQjaYe4DfrStWdJ
         SOPK3hDC8FPCsUSE7nI7eqIjDNcvXCwYNxM9G8ptYtDTONQCvSvyhIagHn7EMyBmpHQ7
         u8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744414630; x=1745019430;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKjBnAI0llRD88HQinqqWPzae0oerPBARTmSqosHWIk=;
        b=J9rxFCxXk9cJtX+0hvaDfMCZdX3vhgJrteHrbHHMltGEOxo/gsR6KARn24GhLuZdYP
         L19wSyTxpJzIqHuxibH6UDtXzwfsvsYXLuYeELe4q6BHeRR6Qe0MDzUoRKgIj5Gt29Su
         HQ8qpgpS9jMWU60C/VRXKfjmO2E+/3NdR43A5A5+yMwHP+fRJokGv/h8KjAhq7oegLSK
         hOqNUyvOvUzQyrBrTgabEU9KMeYmjTG3E5AVE7YCVCOYTJUQkGjRCS4Oj72MaVnloIGR
         i+fzTnlrrFmM0KGvypYvnkPylMysJFjFHgipY13IETqgqLGLnQDwL6GgzlfPoUPZ3+fK
         SA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS3o7euHcxmzBWO2+AR6g1pqIMDtYubMOp/ONox4FaxcBLWEfH8Wx2pots2ddnaBFuV1cFyAQkBtPMDjUx@vger.kernel.org, AJvYcCVkz9KYGBWZQHvGR5UsnVauWr5pKnrLAnTdZTT8g9X6YlK3Ab1WMv3/MGmib9CRMFPEI6PX26YVC4k=@vger.kernel.org, AJvYcCWCFTw2FDIiOhqzCgDWMLmDZKpGI8Kj6ZULr8ePOG5u9uyXcX1bmiNOuS55FXhOATX43HWKGneMsFuaLc2+@vger.kernel.org, AJvYcCWLWymJ4Marc9OAqJYXCc43gSNeo9zuFHC+T2Cb5eIMKIoTHd6GiWwu1rAFIAKkOM/GeWWN0gUDmHV/Eggoh8G7TrE=@vger.kernel.org, AJvYcCX+YXy2bVVWGOjsj3bdtnEC+bl8P3V4/S3vgkMgljR3MpUF5I8PPpE9iKSS11ta8IZOVIG3TiSFMVCc0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mXwShbAiXploK3fTDMX1Lz6NmeftGtDVtBrMLDuJXUKk+X8/
	jdwP9VWgmdN3lJjwBYzXxffxFkdtwaMvwcVNpiex7DnhUdeEWILw
X-Gm-Gg: ASbGnctQJ2R7b+IKvDrQMtpdoxb9QesvoXcnF2d+62v8p/DCsbB2ZxRkKCBc2sr5x6o
	Us23+0rGTzwtXwUZXiUuMiC77leCSSHQttxJVytOq+NzYJKu0zeEIcOUY8AVH88OwgVqYw3wwa2
	h0x6AReEYSqqyhLea4k3EfTdW5ybQNCp2y/rMSlnAWGYUTDgDq5gdjbOm++yIYPl+EIaQPSAjXD
	SIxhjQLiVdLBukQcifLod5JURBzpOxR7yTmp89Bv+iMNvltI9v+jiAOZLjVwa3pqvxY2EdVXGqg
	xHNh3a720soqOjRekRgQMlWzSPgbQeO364F0mys0KOTYGlZqgFCS+aXUmwFjnJzAxgtS
X-Google-Smtp-Source: AGHT+IFJfzFy8MikJxGoTFLuN6tcrmJtPOA/qBHSB3opFc0xc5RXfyX0+z3ecAr5bH4Qt7gKQzRQRg==
X-Received: by 2002:a05:6830:d1a:b0:72c:4032:76f with SMTP id 46e09a7af769-72e86304edfmr3726235a34.12.1744414630055;
        Fri, 11 Apr 2025 16:37:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d7140esm1131783a34.22.2025.04.11.16.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 16:37:08 -0700 (PDT)
Message-ID: <0ce8559d-5c7d-43a0-8177-7704969fd334@gmail.com>
Date: Fri, 11 Apr 2025 16:37:03 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] arm64: dts: broadcom: bcm2712: Use "l2-cache"
 for L2 cache node names
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
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
 Neil Armstrong <neil.armstrong@linaro.org>,
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
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
 <20250410-dt-cpu-schema-v2-2-63d7dc9ddd0a@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250410-dt-cpu-schema-v2-2-63d7dc9ddd0a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/25 08:47, Rob Herring (Arm) wrote:
> There's no need include the CPU number in the L2 cache node names as
> the names are local to the CPU nodes. The documented node name is
> also just "l2-cache".
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Not sure how you had intended for me to pick up that patch without 
copying the maintainers.

Applied nonetheless, thanks!
-- 
Florian

