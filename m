Return-Path: <linux-pm+bounces-22455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE97A3C3BF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 16:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816B6189105B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CBF1F91C7;
	Wed, 19 Feb 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="i76W0ndt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C41F8BCC;
	Wed, 19 Feb 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979408; cv=none; b=NTe7cv9LhLu5zH8Cv6BWFFxgYVl+BLmVGURhPg556/aU44sQ+dIi4r1FkmnyehDBUbMMxFUpqv7hl6Brv9g3Q8txRJ2tlYqKv7sQY8sgDi4VavUW2HW5O3/VbYV2q8a9PVABWVAUaBsAGII+t3NDJ4ghcuRd3B3ezySYlYjQYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979408; c=relaxed/simple;
	bh=oWWajixtlHPEE9PFDS//yTG8eD00WLGc+jcUF5caSKk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rMIXHHWWpuAv8mxZR19R1dUBc5TsxywlPflzw53VtlK/twX7YtVnsnhyDl1iuQirrmEsD8UYNKaoGfM9wzWP4tDf9wfOLt4JrmgQaWKKq0OCcN1HhnQo2IqO/g8vhwCILFhiZrKthTNkGB1XQMlXxd2CVe8WrS+4mGODsRZAo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=i76W0ndt; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id A4A5B41EF0;
	Wed, 19 Feb 2025 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1739979403;
	bh=oWWajixtlHPEE9PFDS//yTG8eD00WLGc+jcUF5caSKk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=i76W0ndt7R0fdW2YCSE3r1spun1yeZRuV/w3I70GnJAOje6cLjmNW98433Lsp1ksv
	 PAzTB8VxQj9/UYbbJc04urECHsRIzu18/+mS9ea81cpuso9T1XEAFKFDUmOa8RRcc7
	 E/dmjZLb2LPZYwu07I52yh99eojtZAEEzy9qPzna1Qrka2hkJPQ4mcvWimQpDSEoHp
	 qg8I0sLMoCN6L/8uggRmes0lGUFgHgdZIERLJcE5y+1bbNnIgYWe9Hko4mx2i/f61X
	 RN0zOC5s8GPEBveJDrEkIpMEVxBALGdchdJaNtzcfOlXr3+Uem4DL0rMV8+/t0hQVv
	 p7wouJCPeJv5Q==
Date: Wed, 19 Feb 2025 16:36:41 +0100
From: Asahi Lina <lina@asahilina.net>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Hector Martin <marcan@marcan.st>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-media@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/5] media: dt-bindings: Add Apple ISP
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMT+MTToVdm72ovNZ8ySySYe5fT99a0Y6bv02NKxADCBCe+pMQ@mail.gmail.com>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com> <20250219-isp-v1-3-6d3e89b67c31@gmail.com> <16f6d4a2-2102-48b9-a0ae-b8c6595975b8@kernel.org> <CAMT+MTR7dhtt3SOMg0K3UakJQftqnc2S-rV41HdHtA+o9aSPug@mail.gmail.com> <20250219105326.GA31383@pendragon.ideasonboard.com> <CAMT+MTToVdm72ovNZ8ySySYe5fT99a0Y6bv02NKxADCBCe+pMQ@mail.gmail.com>
Message-ID: <252808F9-D1DA-4233-A878-5C47595302A6@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 19, 2025 12:05:29 PM GMT+01:00, Sasha Finkelstein <fnkl=2Ekerne=
l@gmail=2Ecom> wrote:
>On Wed, 19 Feb 2025 at 11:53, Laurent Pinchart
><laurent=2Epinchart@ideasonboard=2Ecom> wrote:
>> >
>> > Those are board-specific and not discoverable via the ISP protocol=2E
>>
>> But they are settable through the ISP protocol, aren't they ? For
>> instance, looking at isp-imx248=2Edtsi, the first four entries are
>>
>>         /* 1280x720 */
>>         preset0 {
>>                 apple,config-index =3D <0>;
>>                 apple,input-size =3D <1296 736>;
>>                 apple,output-size =3D <1280 720>;
>>                 apple,crop =3D <8 8 1280 720>;
>>         };
>>
>>         /* 960x720 (4:3) */
>>         preset1 {
>>                 apple,config-index =3D <0>;
>>                 apple,input-size =3D <1296 736>;
>>                 apple,output-size =3D <960 720>;
>>                 apple,crop =3D <168 8 960 720>;
>>         };
>>
>>         /* 960x540 (16:9) */
>>         preset2 {
>>                 apple,config-index =3D <0>;
>>                 apple,input-size =3D <1296 736>;
>>                 apple,output-size =3D <960 540>;
>>                 apple,crop =3D <8 8 1280 720>;
>>         };
>>
>>         /* 640x480 (4:3) */
>>         preset3 {
>>                 apple,config-index =3D <0>;
>>                 apple,input-size =3D <1296 736>;
>>                 apple,output-size =3D <640 480>;
>>                 apple,crop =3D <168 8 960 720>;
>>         };
>>
>> But I may be interested in capturing a 640x480 frame with cropping only
>> and without scaling, with
>>
>> input-size =3D 1296x736
>> output-size =3D 640x480
>> crop =3D (328,128)/640x480
>>
>> Or I may want my cropped frame to be located in the upper-left corner:
>>
>> input-size =3D 1296x736
>> output-size =3D 640x480
>> crop =3D (8,8)/640x480
>>
>> If I set those parameters through the ISP protocol, won't it work ?
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
>
>For cropping - you do not want to change those parameters, the sensor
>is partially occluded, and the crop area is specified in such a way
>to not expose those pixels=2E As for scaling - we can expose only the 1:1
>scale and let userspace deal with it, but it appears that it expects
>the other common output sizes to exist=2E
>
>

The square sensor with the hack is the IMX558=2E The configs there are act=
ually a workaround for missing ANE support=2E

What the driver is supposed to be doing is using the higher numbered prese=
ts, which crop internally and exclude the occluded area=2E But those on mac=
hines with that sensor end up requiring ANE integration for denoising and I=
SP crashes without it=2E

Config #0 doesn't use ANE, so the crops are re-creations of the other conf=
igs so it behaves the same minus the denoising=2E

