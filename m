Return-Path: <linux-pm+bounces-29147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F09AE168C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055EE3A6509
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A1E26F44F;
	Fri, 20 Jun 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="OzsPiecT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5A26E16C
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408817; cv=none; b=lLkk1SLyW13oMKShbAELR0pL5sAb4566xlevBG4lBC9HhbS/qf13XjGPaeXWFqI4A5aJRsykbnmoP6snJto375lcOIIdT54cWN5Doj5tRKTU752Lr9cviPbFeYLKkJ42UJrVQs749P6AVR8TenLHCtOAztAGAWpgz8XLtXjJUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408817; c=relaxed/simple;
	bh=a3mQToStIF6B1IdwttoHX1nYEJ1tyZcwTnGtOMKW35Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CXo/oJ5xOu8faS+/DR8na8mycCcXLcrQkjUiB+FkDvcPQQ/+MI6BqP4x2Sysg0Zj1k/p87yyj/v2blP2/UfuAGxEo5C4FmcX81ogHNi1cI572m0keP4FoF6YW65RQeX0jmv7qcnStr551pVkUVKaWslA1uQ9/ybsJsXbNTw6wBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=OzsPiecT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so3310305a12.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750408813; x=1751013613; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb6LSPnM0jp92EEKrNM76UM1fccTcugFDTVrUIjKDq8=;
        b=OzsPiecTJAWEDjY3lZVKGcTxZo1IjiJb6A2krnBK+QO63UFoy2xb0TJC7c+x27xhqC
         K8WPcXa8R5ILdCCXOBByLgtcytWRNtmsOZ9/JG/zthzGETQq/2fYFtvwclG094H+UI+0
         nIz53UkqIJZt+ICtDSDObVG9OvQ9ORUvlDGym3Rx80kk+BY9BrFKR3rrtR/BriuTB9/k
         M/9Nc9ti9da3+kBYbgfP9Wv4qci+5XbGRDaxp6aALp25RvhqKygC2Ard7nq2Fz63Xxum
         zc4keaPBkwSVzswBkmkNS+1zSyoieN9aWB+bkf3FQ4vcVozl3HdC9lkHMHw+qMQ/jObH
         8r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408813; x=1751013613;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xb6LSPnM0jp92EEKrNM76UM1fccTcugFDTVrUIjKDq8=;
        b=dzS/Uk4LjAVmKS1Ne85SNFMVnVgL75EO6+ZOAIlG1JrkBqm8PLyNVQfbPeONH94wie
         LCdVSXzNxa70jkNiet5X+/XrTPuXLwKfCvYVKuHQswwjZPfbpTOqIoMAeOUXnM6OYF6/
         6l2qjFQQjzJprff5BI26wmuz9m2XbdjSg3oCKJcUlc1y4iWI/z8+uowcYvCCcN8h5XIu
         mZS3OMIq63O5qNXVlcyyJq1jafQHR2jxYe75Hh8xf31N6Z/Gk5iDrAhcgAuQlfqSMdwy
         ljZjSd+KM0u833m9HG4rJvhTivQTF0SBd92PBDpHkyMAdhf2w15AAOqxGBXVvice01Y0
         BA4A==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZuYRvnnfY3K5O5W9yw25hyjEJHNg0nKeu3yR2QRFq0vbIDy69ZrburRLJDOR3TYYhHryz08Z+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzobvXwqphGQNpBrOajSLb2WwvGMI0m9RcPfy4UTIXdD+MJo0vN
	qdBfc9CWRg03xLqFF/dD/53bnRILpEWxmNDow9Ym6gJuJqJHEHbCmIsp0NbWsvPi8kY=
X-Gm-Gg: ASbGncuuCyZYIAKL0cm+EB2bq6KYyNipR9IlWUxMcKlGiBtMbzz2IE2xvJmGrqOm/e0
	1beraKyFuU7ZsY8DzEdVD/PaVmk6bw0FS3uRhFsNNAN0zh40jk/TGH+BfnsfTFRk76w2OPIXKPe
	VX9AvsDavfp3ug8KaR4YpPLcJAhn5UzR2yOwubeV0FKmdvDlP8AGlwiltVIFZBi0wyc4ij3pXXS
	IWqFoWoufsYE5s+GFnjgpD+spxzFCigFEW6FJbDZgzSj4qYcKrkOZyxVoqdsoEjblODKscwn6hJ
	T24/5fHaHEFj/EtqRaaUUb7N/vjWJcFGqifwVAeuzRnUG6504A4z/3v48gnaLNajiuYNTLfJr/q
	U8RQRCpZrgYU2Wzr1mar7l8Hgb2x0vXs=
X-Google-Smtp-Source: AGHT+IHSanY7BYLP4aWQy8kFVBDTWraG5UXAI4rv0kvSKzHjiyN5FBJKlVrNJSNccFlJIgG0wJH/Gg==
X-Received: by 2002:a05:6402:35d3:b0:606:bd9d:a772 with SMTP id 4fb4d7f45d1cf-60a1d18ee41mr1852590a12.24.1750408813427;
        Fri, 20 Jun 2025 01:40:13 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1854362csm1084336a12.20.2025.06.20.01.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 01:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 10:40:12 +0200
Message-Id: <DAR84ZHFZOJI.3CRLDTISWFUEQ@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 10/11] MAINTAINERS: add myself as smbx charger driver
 maintainer
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, "Sebastian Reichel"
 <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-10-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-10-ac5dec51b6e1@linaro.org>

Hi Casey,

On Thu Jun 19, 2025 at 4:55 PM CEST, Casey Connolly wrote:
> Missed when this originally went upstream, add myself to the MAINTAINERS
> file for this driver.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2b570ed5f2f28341a3bcb7b699cbb250ffa2a88..a32e53d89c29cacf6e456258c=
4c7c0206cf8abf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20565,8 +20565,15 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
>  F:	drivers/mtd/nand/raw/qcom_nandc.c
> =20
> +QUALCOMM SMB2 CHARGER DRIVER

SMB2/SMB5 or SMBX probably?

Regards
Luca

> +M:	Casey Connolly <casey.connolly@linaro.org>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.y=
aml
> +F:	drivers/power/supply/qcom_smbx_charger.c
> +
>  QUALCOMM QSEECOM DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained


