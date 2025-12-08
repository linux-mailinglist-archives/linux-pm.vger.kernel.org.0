Return-Path: <linux-pm+bounces-39315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 656E8CAD9C9
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 16:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739E63016361
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98560265CA6;
	Mon,  8 Dec 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MMK8DB5C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7B2248AF;
	Mon,  8 Dec 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208182; cv=none; b=HHPkY6cxsv9px7iLBGvU9NxSWRxXMAwaWdY7fT6EXxYfJmJf4qttwbLC6ysH1oQMqjuN9Tji7JXtXjElqnOc70lz6pFyMimucb/u07S7inVWNGBzABXtCOuRGHtycieVajQg8EAktskICrte9BJojmJP/wr8EWA1qCvucXs6M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208182; c=relaxed/simple;
	bh=RTFhLGhQ0Q50ckCv13XbRk4FdVU/2KzJFRlMLHFvFd4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YYDKn7uIc3zfQL+oBvTepXv6ChV7IBHAgntYZqW2QoGWgDlyhT7xme8LFFXEwCIiVn0ClZkhjj9vAifyAomqdDbMVT5sSThMMBABI00SjIf8yBW+WqAlroMPv8/Z9EQJ4CpbRgRMo5NZJpTfW+ewHQHJ9YI4f8zc86BOACn8SZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MMK8DB5C; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765208152; x=1765812952; i=markus.elfring@web.de;
	bh=Blme6XgEQkOt33/62FRieigeYk+tLe1AihTkO7s3Fxw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MMK8DB5CJqguA0Nv+BQCKmF9J1Z2jA4FlkjGtVbE+8Fr74ekQSCntLnZHL6WA4Pa
	 oH6eJdEEg6ycoCormXnJyRBlCtDTWktJOufrONaxMkRW5+ihTKwix4cfJ6kkTQCqR
	 aTNMgMTkUpmPkRf7gxRBixETtsiEhatRs2utQOaSH0sNfuUVRqMGzCjx8UE4kajem
	 VF4ZVhDHus/3/PEqvKIsUg5T0YtVahOdDVfSMhoPxzTXFIHInHC563YvG58Px3uX7
	 MSGDMvk8k6S5rtR6K/pzC48tPvetncI4c2oJJ97CCqZ6d1mQzGki5f9C8MP8yeMmW
	 Cj8iNr1SYa+WjzsvMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.237]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Meler-1w0sEX2BUb-00meyK; Mon, 08
 Dec 2025 16:35:52 +0100
Message-ID: <eaee9a11-bf8b-4f83-ac92-1d3a32eeb240@web.de>
Date: Mon, 8 Dec 2025 16:35:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251208094242.17821-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] pmdomain: imx: Fix reference count leak in
 imx_gpc_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251208094242.17821-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6nPzKeZkh6j3xytEpXlN0Uo0t+AZ6iwyJ6qLiQqh4pGLpsD8KLB
 /Undl/2mtFWgrn5zQpeq98HbiH8YF5tHSCqHwUN/myr/q449/Mx/bgHE1TZsBEiA+eW3dHY
 UAXU1v587WKGs43Ytv24TMsKICbCLLgkZG+iEq3/lZg3SswJluGPvEMypSnyPkAFZYsIoTv
 qYdkZIa2eiEn2xv3YWlcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jxmKxt7unLs=;H4Ylet+lhbUAz0eebnFS1Fr3slG
 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

=E2=80=A6
> @@ -495,12 +501,17 @@ static int imx_gpc_probe(struct platform_device *p=
dev)
=E2=80=A6
>  	}
> =20
> +	of_node_put(pgc_node);
>  	return 0;
> +

A duplicate statement can be avoided here.

	ret =3D 0;


> +err_free:
> +	of_node_put(pgc_node);
> +	return ret;
>  }


Regards,
Markus

