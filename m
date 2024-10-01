Return-Path: <linux-pm+bounces-15034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CF98C691
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491172837BD
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947671CDFD9;
	Tue,  1 Oct 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgxxUDZn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3111CBE98;
	Tue,  1 Oct 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813619; cv=none; b=etzzGUkHeNOcta8BThXko524GzTilcED+GjSoe3FSFhAZabqYlfuflkgHmo+rnWkPiWSKISQ9MHco/7VAXXmVJv7SEKu/kqDAp7vl6fYcUkuvl0/FGOZhID3Tfi8BSCvmJBYS4r17kvSjlb+3q2Rrq2bArd/T1pi88mNqds52g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813619; c=relaxed/simple;
	bh=gX4Qtn7dFauWuXJkA4dnQSxFosR9cDYq5MRIiJxxfFs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=e4gzVlhnPoTg7iK5gK5TA+sVUiIWYDdpyyopfdkEcMi97axX2blFCwanVZXHtHiUOcBJgbAKFbgFj+uk9ftXKrNtBwbtlcVLi+cet26yCohZs2Rpkho4gC43UR7x8Tuzl0V3ve/yT5dQJ8p10+hTXTw13QfYWuIJW9QWOjb+Hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgxxUDZn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso3267189f8f.1;
        Tue, 01 Oct 2024 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727813616; x=1728418416; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nOWQ2Ev3dvjqaC5TErXUflpk/tqe4e9z200Z1cox9L4=;
        b=ZgxxUDZn+oFEhyj/zptHiGHoU57grFJhEufKu0y+k7gB2uMGT6J+UlmaOVvBLAmWUk
         QV7W97O617cWC+OWyfAW6ssDClfe+wVhkU6UwprTSdrtOWj05sPThrJWOgw+oG+AwheT
         fWu8xpvSRABeXzpVvcPTEMDc7ohcrEnBf1qUXrHqGXAVPOef3bPHR9yRjU7Zmv/+PUhG
         nERNQ0zLmOX8PbaL1Z/5L6AKwRxBiwW1Wa8Ok+ZEN5G61OJED0FLvM2dSL9lCQfNaz1L
         tisbVCDb0hrTKuScyIu9HMZU78nfrVywAvsFqtaXjkr0isSLOjFQ3zLtXEjwfMgWcRz1
         oijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813616; x=1728418416;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOWQ2Ev3dvjqaC5TErXUflpk/tqe4e9z200Z1cox9L4=;
        b=raGXEhvfxEnc15qi5XMXQMqmYd9BrzADM4vgCsHWECXYPw5Tol2P97miHSps9n1Q5T
         oImERPMO05HKYqdRU2TqOfwRon0EJIYtSyk0SwEenKrqseOJjlS+UZt1s8ed0f9q7nXb
         VE+P2/447kQFOo0NG2v9CXk/hJku8Isz9PWorZUr3UCMBJ7PXIJnsCL/1iFizUKXNrCR
         6OupO7lVF2kn+dpLJ9jw4PPi+sJG90kKKJTPVb8of1tiiJOVrdTwuz6umaGYfnICNJeF
         HlbtMcSiDQjfOqfeSR16t+s5KhSp+pqAH8vUqrJ0XO/oZqR6dwHnUtuxxbpOCGjPXWxN
         gvCw==
X-Forwarded-Encrypted: i=1; AJvYcCVXSuazo3SRGdXihyCpUVYLIBfummj4mv8iNUS74whn7kYuP0NUF5a27S1NpvjNJi1aDEerMUPfIFk=@vger.kernel.org, AJvYcCWMnsMtT0J/piKfTsP8+9OPa7EXxKeYH2G4Wy2oD81T0l6KtiqZimZoj0z6C8Zl5OYFyNSyODf/gAwJO3Ro@vger.kernel.org, AJvYcCXvV6R6mlaQoJbYWLJGgIUXWr7rm/QI0HokVdG2t29AY33sNyJo+9g6Nebry7ajMaliMwKs/idv+FdBZhil@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv77BqtqEK0C/PQeA47tqavFdZ28BE29vRRQ2/cvnmAVn0ewBX
	NzyFWzHaFtwGSF6SRu7y6Ek49YrkKc+Car+FumN5oQR8uhiDO5bPHmowx+SF
X-Google-Smtp-Source: AGHT+IF5y09gFONJUwSfDVPxnwM0RFIE9e3uG9ePmDaoH851C12uT6iEt/P5vG6CIW+X8Y8h/y2aBQ==
X-Received: by 2002:adf:fa05:0:b0:374:c3a2:2b5e with SMTP id ffacd0b85a97d-37cfba0a664mr559595f8f.37.1727813615824;
        Tue, 01 Oct 2024 13:13:35 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564cf63sm12742126f8f.16.2024.10.01.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:13:35 -0700 (PDT)
Message-ID: <66fc57ef.050a0220.27e956.af8d@mx.google.com>
X-Google-Original-Message-ID: <87setf60pe.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,  linux-arm-msm@vger.kernel.org,
  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: Fix reference count on CPU node
In-Reply-To: <20240917211325.639765-1-mikisabate@gmail.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Tue, 17 Sep 2024
 23:13:25 +0200")
Organization: Linux Private Site
References: <20240917211325.639765-1-mikisabate@gmail.com>
Date: Tue, 01 Oct 2024 22:13:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dt., de set. 17 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> For the qcom-spm driver, an early return was not calling the proper
> of_node_put call for a previously acquired device node.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-qcom-spm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle=
-qcom-spm.c
> index 1fc9968eae19..d3608f47d02b 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -96,8 +96,10 @@ static int spm_cpuidle_register(struct device *cpuidle=
_dev, int cpu)
>  		return -ENODEV;
>=20=20
>  	saw_node =3D of_parse_phandle(cpu_node, "qcom,saw", 0);
> -	if (!saw_node)
> +	if (!saw_node) {
> +		of_node_put(cpu_node);
>  		return -ENODEV;
> +	}
>=20=20
>  	pdev =3D of_find_device_by_node(saw_node);
>  	of_node_put(saw_node);

Gently ping for a fix in the same spirit as [1].

Could you take a look whenever you have some time?

Thanks!
Miquel

[1] https://lore.kernel.org/all/20240917134246.584026-1-mikisabate@gmail.co=
m/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmb8V+0VHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlA6UQAJopj8NL7nM8hEZxhIkb6N0dfg0E
uJYZq552JINOQQLg8r3Qhv7JWE9UxCfUA+xPBc9ZQpX8Zbn8M8VL5gqHR4B/IySi
nTQWcvEKkb4WWekkR/3XFnj9NFhg85q8DwP53zrjmSnbTyeSschW75DFINyO/vNs
FbFYPbRKRvj6yP17jixWlda9hPc5f1Jsnm/YTZfnBDA6xYvEWIoneQdPBHWkuYk6
OK1ypAKlB+Wpv9U06TzyMU1EMQDif29uZFtrFlzvc5z8TGUtRjoh3A7MNSWhr9Ze
CVLesfB04Ns/v1XoHFbZkCnTxO6E25BA4ZnU+XS9cnRxJrFChtW1HXwFA61JFj9n
Dwoo9GWZY7grbfvuCLN0HrBW+XQXSe/0EJe1OGLG/sz9lRWThwW6pbHZnkxnkum2
OFyup8y3JBgcnbiU9w/O5bAoSx8EeyeF3ybu0s5Cm+VPbiXLwozO5LFZGt2WP3n6
x1nluJc4kMZbFz6Tb+i8ILZ0rL/de8BjQLUc2lNNqXIzjpXu38qLUN+LU8NUfg62
z6g+o4mZeUYfVNgXDW/b02th1VEoO9KR7yuOWNaUd0fiFC7tbVgdHmORBl26mJa1
onoG2SZCe3gt2InhqqSKRfF0bW24jqSKWb0EHRk39J25AYaxheW0/onk/ZPinNHk
bNgoJqZnVCjK+6UE
=Eg9Q
-----END PGP SIGNATURE-----
--=-=-=--

