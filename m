Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8584F558
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfFVKrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 06:47:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37795 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 06:47:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id d11so6791424lfb.4
        for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2019 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=nk3V/ug0utzG8bId4Xioq+xpoAQj2O0VGV1F/k8T58I=;
        b=sJp4H8FX63frQtUXMM+hG54Wh5WWkDSOse+IDRgh+Ca/AZFbypU2EtHDDTGMcurcUP
         mNvZyhUAXWpDtZ9BfvC8V6aRnD9pWCV2pqc3v6n+2d8HnCAe5+9r2Ctui4vkav0Xroya
         Qtx4IVEoQTET+YB8uTOuWSO93DzqoF3dasTEp7oNNZoQjV7HOOgztyzUcs6G8fNtoETS
         S41F7DVqh+vbo8aEoBK5aNqdsyO4bXcBJqdz66c5fu5AveG8mjVwNYzy7Kp2obpejuUi
         YSTZIfXURABjzW0qotKZa/icJWA1dv0DnmnpptIpn1XpW1/sut54bs9C8+8T67TTC5X5
         WfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=nk3V/ug0utzG8bId4Xioq+xpoAQj2O0VGV1F/k8T58I=;
        b=htqNrBdQ1/3AKPzYaiakfahQ1yF8K31Ljn0/fywBjH/YwU4Vq3MOHpFb58HdR8pkgi
         ztP33rW+TEVDNvU+Pjh7F2TV7t7doG+47YHcjvNZw9wKB96qemX5jN9oOUeHtQ2z9dQD
         hZ7Sm+6HMs/KXtSXdjZ73kURcMi0Hq9dUr0b/nbiVjoYIQOI5QuiUoEaTdAdDxbnSIPT
         i9gHYJrL8MCoB50DotUNFrG28Babfvzcgcs1IxTNUXCLAb9kG2Lh661cf8lsFsB80VP9
         +GH+AIeFRXgGFZdNzcTs1Am4FLuk10FqVZrDV0L8T31KFP7Xv9Amg039yPIeJYNSqrHc
         Ayqw==
X-Gm-Message-State: APjAAAVK/ppm+PxWGm5D4/fbax1KcjZjJvUnrFkP0z9YZKUxgV+TAdaQ
        3P1br7N3sC4nfeZeYhet0TM7VbaybVvODmNpKu4=
X-Google-Smtp-Source: APXvYqwmXDDYPlCYMRli8dYPIbKxiielNlzHRFHfbWeZ9jTQFt1IndtS7+3hNXUxM0KgBaR2oHQcktUHatU97jNqHDM=
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr30523438lfl.121.1561200425118;
 Sat, 22 Jun 2019 03:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190621213949.27018-1-ezequiel@collabora.com>
In-Reply-To: <20190621213949.27018-1-ezequiel@collabora.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 22 Jun 2019 19:46:28 +0900
Message-ID: <CAGTfZH3WenT=t6bFWy7sZCKhcPaMBrzTs=00DeSFU-0Sm-qS=A@mail.gmail.com>
Subject: Re: [PATCH v2] PM / devfreq: Fix kernel oops on governor module load
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, kernel@collabora.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 6:42, E=
zequiel Garcia <ezequiel@collabora.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> A bit unexpectedly (but still documented), request_module may
> return a positive value, in case of a modprobe error.
> This is currently causing issues in the devfreq framework.
>
> When a request_module exits with a positive value, we currently
> return that via ERR_PTR. However, because the value is positive,
> it's not a ERR_VALUE proper, and is therefore treated as a
> valid struct devfreq_governor pointer, leading to a kernel oops.
>
> Fix this by returning -EINVAL if request_module returns a positive
> value.
>
> Fixes: b53b0128052ff ("PM / devfreq: Fix static checker warning in try_th=
en_request_governor")
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from v1:
> * Rework the fix as suggested by Enric and Chanwoo,
>   handling the return vaue.
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6b6991f0e873..258f70c1e48f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_gove=
rnor(const char *name)
>                 /* Restore previous state before return */
>                 mutex_lock(&devfreq_list_lock);
>                 if (err)
> -                       return ERR_PTR(err);
> +                       return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL=
);
>
>                 governor =3D find_devfreq_governor(name);
>         }

Thanks you for fix-up.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

But, you are missing the stable mailing list. In order to apply this
fix-up patch,\
you have to send it to stable mailing list. Please send it.


--=20
Best Regards,
Chanwoo Choi
