Return-Path: <linux-pm+bounces-24246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB9A672B1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 12:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C6A189DEE7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3997209F5C;
	Tue, 18 Mar 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRXeEfck"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5075205507;
	Tue, 18 Mar 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297275; cv=none; b=gnkwN8y9occkztisL2c+hePyW81msT5cMyWnh3WJUn75pAacZdw4uZyMZzhQQfAqSbFzssoTifj7eE+6cEyeJMZ2Buts+xuDV3FzpWjJEdDqJboBHB01GQ3FqECC8UuiJ/8ocuKbucrxdnWk5ZNvk+v5HBT2kCxSXUuEY7JM2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297275; c=relaxed/simple;
	bh=1btfEb0nhExcNTi2rYAFFqhfEYGkL8D2ne7lYeiVgz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTcNPMuW3Ua4YNmeFzuo2U3gVNBcxP1KDpz+iucoWRERmLK5KPuPxi+oHQnRSD7J2Q2y38q30HhOH0pzFV5RSpZ46XT4XyGLfDmlvuQslA9UVm8Pk3BK6bYvlzVNwYXfUSvCLNNSM8zChOfmDOHU3ju9qGVdGUc2CxtjTFo4ieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRXeEfck; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a59so61264081fa.0;
        Tue, 18 Mar 2025 04:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297272; x=1742902072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zcnl5GlKCMfJmW1p4sjVmtozHXscsIgYow35rf7G1GY=;
        b=DRXeEfckHKFwv1G1H9iKYW+9ZCweGoEkvJYe5xoCozvT86KAcjEmbEX7udr7jHOhMi
         htnxHMJSrJmsigtowMic0zR7B7B4IlhV8OSnIC+R1WK7ieeE4exDSvh6/iEGZ2OWAdb+
         5QlSruWaK1hPaApQ6PosO8b7mlv+/c9atRK4g14rF/QGvTKyfP3Fw1nx5tTSLVDGVNa/
         2HPGdREQvhRSwoGkf9fmr8W2YnuMgz7ZojilGo7mNyy2fcCRT2UXkkYuWaoAxQiBWlv0
         7aU1nb681esM+wgZNLPXC9/nqppGswV0iRUpzL/CrpCmbPM4dDAF7w5W++9Mu20/7fD+
         fRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297272; x=1742902072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcnl5GlKCMfJmW1p4sjVmtozHXscsIgYow35rf7G1GY=;
        b=UM9WKMDwEFExBr+hkav8B7Lk/ZNUn3CZcTzyFAI5XrR9KbmeSj94f6NrmKONbHmV64
         QB99SW58XKB6o8dSTryE7T+fqTDIZPK6xSJuMLYZKZR1BRJ2n2UJuV72pEfCIikZGv8G
         7tuRQxgE2H3eN9wi06QCoxa2wVteE1QY2BpeA0NYzQ3b0PLYwcRKZdwwZuEjEtXUqSR3
         ugcst6ubLvWkyDrjJneXUhdN0/bkbur6EYT3o5DIn6fOGrzKMZU+R/u0y4lC1RHfHKWL
         vOR4a7WIQrZNVn/KstgD1DBcrnzoQgOxijRTM3pp+saDv1C6Gz/nG8Yx74cL2FhwQKsy
         ivBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGkOXsd+t7y6Av6TTTU7+HYXRo8mDxfZA3A4GlJOFpgl1T4GJZXQL/hgEp5WhU/mfFZQnpqYqFZ7LgqHc=@vger.kernel.org, AJvYcCXCXr/BhXQNu7JNUK+oDmGJIm2IhGJYeIfE0JRX2ss5RBDSIxamiFzytkS3Rs15qOydxiAAlCEY1ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUAhSXjV0GTwgGaD5GopjeM1++vGPBvuaaFTKG8pQRjAv6K2M
	kDWfcEEkuBjxXtMfV1+LPZzPygCIuuyUu4o0LtA6cR1ijiYNb7ei
X-Gm-Gg: ASbGncuPg/EeKd9iTzpyfqKRzGpp7vRb+mpX9RcmsjQjpGmuf40FXKBLRAjsoUwedsi
	3f1BCwdQ0/If5YunnXb2zpyH8eP3WXqXzFTCjXI8MIID/2daVvleBcCkeM5zaHNEsPER4SSexL+
	gt/ezRBIYSbtFqhzA4+uKKgQz7vf10JvYWQKFqsJxUd9VAyXbh8YJxBsw7hnMYSg2ePCzy//eTD
	nnzdDioK748zHwWX19aG8U8cZyxlffNCk/qSCS6B08QdauZ8qcMEPtS/EwtPKe+Cq/uUeLKL8Bq
	nPU3FDbjGmYpuyjKCoWIllA9hT8hGITt8zMByxUlnIIw+xZyi4ERaAlWqA==
X-Google-Smtp-Source: AGHT+IEvZc01ulZSub0QgeTOuwAOi7z7tliPNhgrvh4e5mEa0+pNv/UfnHT4a0tcm+JYufa1tEjSnQ==
X-Received: by 2002:a2e:a9a6:0:b0:30b:ca48:108e with SMTP id 38308e7fff4ca-30c4a74da96mr99734661fa.5.1742297271619;
        Tue, 18 Mar 2025 04:27:51 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0e9990sm19630921fa.26.2025.03.18.04.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:27:51 -0700 (PDT)
Message-ID: <50205854-b8fc-4022-8a07-ec36d8203f87@gmail.com>
Date: Tue, 18 Mar 2025 13:27:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] Documentation: Add sysfs documentation for PSCRR
 reboot reason tracking
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Guenter Roeck <groeck@chromium.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
 <20250318094716.3053546-8-o.rempel@pengutronix.de>
 <cda899c6-4330-465c-80b2-63c9da73505b@gmail.com>
 <Z9lYA9yUx62wNISq@pengutronix.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9lYA9yUx62wNISq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 13:24, Oleksij Rempel wrote:
> On Tue, Mar 18, 2025 at 01:17:38PM +0200, Matti Vaittinen wrote:
>> On 18/03/2025 11:47, Oleksij Rempel wrote:

>> A side note which you can consider if you feel like:
>> This, as far as I understand, will also make the ABI out of this. So,
>> perhaps there should be comments in enum psc_reason and the defines in
>> Defined in 'include/linux/reboot.h' that they are part of an ABI, and must
>> not be changed? I suppose user-space tools may get unhappy if these values
>> change between the kernel versions.
> 
> Yes, there is already: "Importantly, the order of these values **must
> remain stable**, as bootloaders, user-space tools, or post-mortem
> investigation utilities may rely on their numerical representation for
> consistent behavior." :)

Just noticed this. My bad, I did reviewing in wrong order :)

>>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> Yours,
>> 	-- Matti
>>
>>
> 


