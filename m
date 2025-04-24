Return-Path: <linux-pm+bounces-26092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DAAA9A307
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 09:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6774410F6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689A1EE7DD;
	Thu, 24 Apr 2025 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Xq6UZQzi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF41D8E01
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478898; cv=none; b=AgBarx3zV2v5r+ojDqRYv8NuxrgqOEwh2Q3st6tiufydtQob8YMApp2V6CwjFY8IFK1L++yokRHmn8JGop+ssi0kqFm4NrmhxJyJiyGabn9bqP2XfLccJHvtvojrG514beH2Q6rG1XCPzboqeyMG7+45vJLVHqScXXeR4zIH8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478898; c=relaxed/simple;
	bh=6soEZQ4kJUtvIiqK5puOZE2rScJp6QCdTzCCiUGiRxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJ6c/d/n4Xvd2tsKk1qxFjkQChR/clrGBJT8giJoFSOeWPUTNRZjDNFTvqH4sYU1JrUzxOWC70pwH02O/58sifU6cRwmTnX/hauPrPFVVtPXxwTM2Q5zF5z2zpYi3AAMGIKT0wSC8Rsy6qltWyXfljflM3Tb5r7T1ELsEqoq+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Xq6UZQzi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb94bf784bso8435966b.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745478894; x=1746083694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+B8Lq9RDCcRwOgfM91avCJcgWbWbGSMVAU80sQQPWI=;
        b=Xq6UZQzibfvGVdnwkYbd7NWgiWC05fNrhf9y/0ZSiM0Z7LQhJg9XZHgrUjy9LPC99j
         EJQAIft0BEKZ1eMAYzCFRBPZzO3ppYJziFE6SiAKn52n1iYAm5caWnL4YBWtFb6fcqxQ
         0CfgzwaJuLQHEizVRT/eeN7PaJA+owTom8aEJVlA0wQaPK0NCqNL0aAfwD24Jd/rvSEF
         HBb3Cbo6qnumJ5mfHEUtLNFmx7Fmzf5Xli+VaQLix7V19h2Rq120bC7nkBVrdT5/wAPf
         TLYSvFVXw4IuAI1qzXpDXaECS6zheezm/LEyE8700zeehsbQPw3XyXYO4o3KXiQDBtQx
         VgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745478894; x=1746083694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+B8Lq9RDCcRwOgfM91avCJcgWbWbGSMVAU80sQQPWI=;
        b=vk8izRdQYTXVHs74nopdSIcfH1vraGvDuAO9lC9uwI5l7S/BvaDUKjTYTz0HpKvQcX
         89oHmWAPiNfr3Kd8y4fXNYGjD7PtT0XFpqxXm9+9GV1PQG1jOSPIbfrFIUDVJznByn8Y
         qCcm/8TiVdlsQqw7+iYOWTXVTSiWclf5dkwJQIoPbBScQzM+ej16gkZzHEu8QGypkwGX
         QGqBGDhR5GF/MU+Wd90JM0tBQYWAyY46a7Dhry0YZJRdThhyzmrcYfvtpcW3Efe9LSPZ
         hvLIdzaUwzX6nS+z9DofZeZw4M9O/Q/c6ihOSYXFqRZ3Ek6+PxWGnmlwGfcSf/l6KsV0
         uqbg==
X-Forwarded-Encrypted: i=1; AJvYcCWgPmkbip/+I3aTgoKuldxeTMFsYV6dG60WJmadqWCQ08ptQKY9QVG/CgeiVac1zJFdpdp8cH93MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYT8xBZHpFi/5cY9D85PK9tUQF1b7Bo4X4jyYzl9hbvr5Dc1Om
	dXE5770lC2/K/OQreTHULlpm7S/u0A/Fo+bKx1diX8zwTbdJDf7vOfwPGSjEedS74IYMP4dUjAn
	qtHny9TpwdzGmC59Y7ARGXCyWG4wGCZWsiMc/FA==
X-Gm-Gg: ASbGnctzErnl/qG07CDCRFo/rFWqEgYSvQVVHilKrVHXxJ5ipibmNdUW5dllM9/DxZJ
	NxB+w0o7x1cPO0MQnI54YDELdPvrNUVFAFzODioMph0fkIBPxGP3q/xulGPINC+3CWg44P6+/Hf
	3PGksN2Nzx3K0aL5iHddcehT0279VKFCvctt7XeqOjWLCPH4jWiHmR43Y=
X-Google-Smtp-Source: AGHT+IEyAiUyJ2mt3265jGzrXL9ewNYPCotZUNj9QN43I8BqsNkYBnMDkmlm1PZ/N97S/0QtxYx3zQ6j0NbtPT1J4KM=
X-Received: by 2002:a05:6402:35cd:b0:5ed:9811:dfdc with SMTP id
 4fb4d7f45d1cf-5f6ddcf7f9emr548541a12.2.1745478894059; Thu, 24 Apr 2025
 00:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-11-hch@lst.de>
In-Reply-To: <20250422142628.1553523-11-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 24 Apr 2025 09:14:43 +0200
X-Gm-Features: ATxdqUFceKzqfCTaFW1t2hUyaQzIpI3Ey7xNjxMyLwpQpyjJSAnOh5Bm8Qq-E8M
Message-ID: <CAMGffEmB1Y22T6JosV+aJrTf9NWAabuJqovy65+mMLsOcx1ktQ@mail.gmail.com>
Subject: Re: [PATCH 10/17] rnbd-srv: use bio_add_virt_nofail
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Coly Li <colyli@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:27=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Use the bio_add_virt_nofail to add a single kernel virtual address
> to a bio as that can't fail.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 2ee6e9bd4e28..2df8941a6b14 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -147,12 +147,7 @@ static int process_rdma(struct rnbd_srv_session *srv=
_sess,
>
>         bio =3D bio_alloc(file_bdev(sess_dev->bdev_file), 1,
>                         rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERN=
EL);
> -       if (bio_add_page(bio, virt_to_page(data), datalen,
> -                       offset_in_page(data)) !=3D datalen) {
> -               rnbd_srv_err_rl(sess_dev, "Failed to map data to bio\n");
> -               err =3D -EINVAL;
> -               goto bio_put;
> -       }
> +       bio_add_virt_nofail(bio, data, datalen);
>
>         bio->bi_opf =3D rnbd_to_bio_flags(le32_to_cpu(msg->rw));
>         if (bio_has_data(bio) &&
> --
> 2.47.2
>

