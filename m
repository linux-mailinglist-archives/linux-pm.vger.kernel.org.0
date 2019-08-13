Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF198B031
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHMGye (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 02:54:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36390 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfHMGye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 02:54:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so12962143wrt.3;
        Mon, 12 Aug 2019 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HmxWmdZQp2h3Mf8R3shm0zEHrmQAZMBjreMOHj/d7CE=;
        b=vBQlbgXq5tVGz+djZUyAcs3vXxa5uTILuPadfGsIj0rhPqciYisx+jWAI9vvQOOp6W
         aRNnSv4N/xEoeNJFj4/OTCc70xdq5k+DlkAdH1GPvhUvPs9NqaqNFkdLun9IFFdeDTPI
         Art5aI1FM/5aCRnL8N7IJ1z3pahFR7Ne4lnSUHbeUxhvJNW64K/TfCKhYXK4a8UXumoD
         4GeT6FMZsuDgqvN7WK1BlOZJr2KYXJmuxMkIe3b559PL3gSfpeLCEN19H805KY3scMqh
         yvtcrMjhH5rFXupU1ng9AzOO/CLz4oNK7Mie4j/hPU6EGJOAVN0S4xhao+PNO90nGdQH
         Y+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HmxWmdZQp2h3Mf8R3shm0zEHrmQAZMBjreMOHj/d7CE=;
        b=Fcs2DlfX+zhDC4EQaS88OYHPW9DbWco+wfFCqq0dMBHLo/xTr6WsyoFX+EVZS6Dd8R
         tW9MZoNGiJquIzl+1ao5TyNNmbstZ1jny4lONh9ntrDh6i6w8n5OIiqNwrmZ3P9dsPWL
         MHGC+uPK2EDXjbyxQOEM+fgmaGsMgchiASlsQHp0XhrVjbIml/5lxRszV0WJtDrKc1Vc
         XrC4r4KcVPKuODTIVkkaDAPYDQYub09DrkkLYkQFRy3zbNHpU7nhfgHenvT1za72qG9o
         FJoPgAmRO3K8jTRIVuArxkLUT870r6S4LQ8EaHXUrSXeyEj197FvPji5WQcTG/bGh5M+
         Yhew==
X-Gm-Message-State: APjAAAUa5c990bbtH5bTISSRPzfIKCJG7QNRaCaOziSFglaBlLPg4uia
        5fJD1J6gIbcnMnVsJX7WRpI=
X-Google-Smtp-Source: APXvYqxCJe3WTU002Why8JfSlUSWeI3zWhooqTf6uJI7z7tieUSxWHXyZzgZ38Mwnb2pRpSoO2jdCg==
X-Received: by 2002:adf:db49:: with SMTP id f9mr42709084wrj.112.1565679271277;
        Mon, 12 Aug 2019 23:54:31 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 4sm953644wmd.26.2019.08.12.23.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 23:54:30 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:54:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: N900: Remove isp1704_charger.h record
Message-ID: <20190813065429.xhlqgcdyaxlqp537@pali>
References: <20190325212737.27322-1-joe@perches.com>
 <20190813061358.17223-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="74iuywupsfvvy3b7"
Content-Disposition: inline
In-Reply-To: <20190813061358.17223-1-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--74iuywupsfvvy3b7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 13 August 2019 09:13:58 Denis Efremov wrote:
> Update MAINTAINERS to reflect that isp1704_charger.h file was removed.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: linux-pm@vger.kernel.org
> Fixes: f5d782d46aa5 ("power: supply: isp1704: switch to gpiod API")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29514fc19b01..2776e0797ae3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11400,7 +11400,6 @@ NOKIA N900 POWER SUPPLY DRIVERS
>  R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
>  F:	include/linux/power/bq2415x_charger.h
>  F:	include/linux/power/bq27xxx_battery.h
> -F:	include/linux/power/isp1704_charger.h
>  F:	drivers/power/supply/bq2415x_charger.c
>  F:	drivers/power/supply/bq27xxx_battery.c
>  F:	drivers/power/supply/bq27xxx_battery_i2c.c

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--74iuywupsfvvy3b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXVJeowAKCRCL8Mk9A+RD
Uu+7AJ9RfV1sAm7mMwwT23afLImsnB2TeQCfQV5ZJR+KocAVqw2e7tHcJGU8D6w=
=ssDQ
-----END PGP SIGNATURE-----

--74iuywupsfvvy3b7--
