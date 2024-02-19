Return-Path: <linux-pm+bounces-4071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994E85A25E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 12:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096E4B26881
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641402C6B6;
	Mon, 19 Feb 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv4ADKVb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3C2AD39;
	Mon, 19 Feb 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343200; cv=none; b=aFgxviiiG0E0OR4gaRB6DdibLuHRYjb8iNQgWW5QtpsQNft6DxYyAMVMZK6HgbmFDZBW2Ser0bn+UX5rVoO9dySHlVhczjOK3RhASU1y/Y6nTqPWAwQT7sS7zmRan+99nvoefPd452qcDzCoEKAYeqGfdTF96qjkF0sMpLDmhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343200; c=relaxed/simple;
	bh=Ctoe8tbX5PWTk94jouBCJwWWO1XDyt0qRZhUXobJClY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6qwwUirkb3PGdNXJbP/uHP3r7IJMA+IllSyxdnJV1Tx4E9qkPkKxuFCzgrVe1bCvxJF6ygP2mGGkT4Suso/+HqdZz9/R+MEAmqUJ9LrYfwhYlR3v3UpPaLsgT5vzJM5PmGT4ZBoE8ZY7S1Hw/iaG3QUXcX9ed0VOBwqeGk3mRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qv4ADKVb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db8f32cae5so5877405ad.1;
        Mon, 19 Feb 2024 03:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708343198; x=1708947998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9Xi9Ryp0c6Uxee29pPnUVNIEZkdMvXtNoeHuLsPL8g=;
        b=Qv4ADKVbw/6krylanLJF1PW6OiFzuRehQ5DjxDc9ZShUBKIb8TiIXYIH46oxXfrp7A
         b7pvqvTlz+GIlY9EhpktsjDRomJl9yJZCIsrp+etK7JFtLoFhcMLmYxpKo3/goWxa+cW
         PcsbJw6KICygxMtFkz/PDrhflKyISHNQC47N13+vyT5VcMDiHXC2U1Ho1Md3fK34ONeD
         kRlVe/YrmRIVwj9OLyiT6ehZJ2OviBJOtdT5Nx4Ic+0X0O8COMUstnAUqLyWFC7mLNsT
         j2e14cdkc6uvIj9XHSjJUnhsPRUQZNf+p5y1fnDE45FYhoclVFFBFCnoZGZh+FYHe2++
         sHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343198; x=1708947998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9Xi9Ryp0c6Uxee29pPnUVNIEZkdMvXtNoeHuLsPL8g=;
        b=elRycfkDRmeUPv2A8djUNY1Urdy0+RVBsAnnKlrCNNMefYybRf9K7Z5vec0bH5lTX8
         uvZXgCiilPUw+6+R4lqAAjn9UvCm/NJq8pV+QLsYAUGqrJTTFaSxgtr81A22uE4FI+/p
         fSqsRZ8BeZQVbCngmJSieWs3E+9KWACENy5f+4FiZuyNAmJh350O2qtReJx4mJslegTC
         KA0jc4mzzZi0P/wZUk+Byb7rbkpeeebHh1eHv3mWDWGZ0L5rlqW8itzeT7AiNuChNdmJ
         AvNcqIAN6j9LUO9KyLaHUIxw0f3RwbM1aD7goObuAjX3yUgK+UKszbeTX2N+4bEy9Sgh
         h5fw==
X-Forwarded-Encrypted: i=1; AJvYcCUkLlmhgtZ+1HZAGveDW80fJTAWN+kYoVjFOjsCRxlcGXrVYs0/Op+pMyoPHQiYmOcTDGeOq2k6s1ItvqZh0X2V3jXpHK6uKpJVwnhRWTJBTCBBUwIN3xF6pMFqapPSp+fdHBcK
X-Gm-Message-State: AOJu0Yz4AR+9pU2im7x+hc51m7fBYQrNYL8s56oVuc4LQz9hP5i38zSB
	DUYCf6l5k/Dz6IjJA9PJ4+CjGHeAnhnhz6G57qnYOedax/Gxl0GJNdNG1gag5RkxySDxE/QQx3E
	E+BqEB4Ih1MHG4nG4H9YHVjw0i80=
X-Google-Smtp-Source: AGHT+IHwXZAW/5cbiaeDOrhS8iR9yQpUlWIA5gpaTaWAAG4Iqt3GcR/yI/k1/F3G9ORC8Aq+JVj7403n3VQejHCu7PA=
X-Received: by 2002:a17:90a:1307:b0:298:b4da:f90e with SMTP id
 h7-20020a17090a130700b00298b4daf90emr7830229pja.1.1708343198085; Mon, 19 Feb
 2024 03:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104124952.1975160-1-festevam@gmail.com> <170483575880.3250905.813888197504018809.robh@kernel.org>
In-Reply-To: <170483575880.3250905.813888197504018809.robh@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 08:46:27 -0300
Message-ID: <CAOMZO5BPVe-is8Xvk3-YUZSupmLNj17pKE=wCveknV7LhUReRA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
To: Rob Herring <robh@kernel.org>, daniel.lezcano@linaro.org
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Jan 9, 2024 at 6:29=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
>
> On Thu, 04 Jan 2024 09:49:52 -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> >
> > The number of fsl,tmu-range entries vary among the several NXP SoCs.
> >
> > - lx2160a has two fsl,tmu-range entries  (fsl,qoriq-tmu compatible)
> > - imx8mq has four fsl,tmu-range entries. (fsl,imx8mq-tmu compatible)
> > - imx93 has seven fsl,tmu-range entries. (fsl,qoriq-tmu compatible)
> >
> > Change minItems and maxItems accordingly.
> >
> > This fixes the following schema warning:
> >
> > imx93-11x11-evk.dtb: tmu@44482000: fsl,tmu-range: 'oneOf' conditional f=
ailed, one must be fixed:
> >         [2147483866, 2147483881, 2147483906, 2147483946, 2147484006, 21=
47484071, 2147484086] is too long
> >
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
> > ---
> > Changes since v3:
> > - Rebased against next-20240104.
> > - Do as suggested by Rob:
> > "So short term, I'd just leave things such that they don't warn or just
> > drop the conditional."
> >
> >  Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Could you please apply this one?

