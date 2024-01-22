Return-Path: <linux-pm+bounces-2480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B13836B9B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1359284E18
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F06E405FD;
	Mon, 22 Jan 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9JU4E9n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26659B71
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936934; cv=none; b=Hd+Sb49BTyf0qkWGq/ZbMD/lL/XnW7TFAxJS+8PflsdbUXKBV13Lob1qUGRqLYDVC9qEWhFVyIJf+bjcH7gV3oRJytg4uI8YmF6DboDjrmJv2hZ7BSIbLGrqCEoSLXhsrqGVtx6p6Shyf8PGh+cNkiBiXzpKP0K/Ax4naQJvMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936934; c=relaxed/simple;
	bh=yUIpNFAl5lX2MSMJsIr4Rt+gHjzzG5IQtNjQFh708So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX5v3qHohjCUIOlii4xALx9SaV4Yr3qTxHpfhaeCpFFumUiVxdnv8P3YEojmqC0BXoJDfbnCsdyye7NCyNfFE3LdNvjdQrjllHcAiYJUOapOfg59RKEiyD5jxaS2hm+Ac9Qs/FbqGnq9AJl5fd9OKMHw6t7YVlepe/IFccgkarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s9JU4E9n; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5edfcba97e3so31866737b3.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936932; x=1706541732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+b+QYLywqR5igbk2Cu7AUp4ujqL3bIq40/9jub26OfE=;
        b=s9JU4E9nuEHNYjsJk3ScWiK3Hj7Ke7QhV/4I48Lvm7DVM8NzxVHPoE/0SBYr/65FtZ
         LrV/Z8Ddihe1Lu5uwGfB8FA2CaIUU35fvaKqNv6smFkQ8IY6NDwb/wuDqE+QMpSbk1Vv
         M1O/vJofz7zXYoK9S1ECfKc4S+bUo+LcMCyFwVl6IGsOAjxlC0YhuqzoHUNLM5pXyBLh
         1GIzFqKvQ5MPLrLNrjw+5OeXjww0p67tHb+7wWsKBDavxvwkxiwgC7B0ZfzcJoeknZbr
         6ZS5ZBBL+qbDN5Aiq+Tj5Gz1BMF6Qmo7db5lUTyKsy9dIBMFRoFlj2luq8Z7iIaPvPbP
         twCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936932; x=1706541732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b+QYLywqR5igbk2Cu7AUp4ujqL3bIq40/9jub26OfE=;
        b=bFKujAu2xidDt7Ma4WBnlcI67KT41TM0WTKuDLUp65iMSdRESD07iL8HxnO6+tFdzG
         +b1zlqQZ1CB+dpT29scz/qwKEzK5vppubWX/m32HS8AUmrtgYiId/aKaHlQS1gmy7dix
         c/gC6oOd7pdpMcu+YITQC+HCT8Ccb5YBUvzkzh0uAuUjZCyljBDVSxhFVGgwpTTIDfIB
         RUafKEiNC0HpfZshbrbS1AUfZKiBOmA0HnDhlY5iDUjtak1tD6sbF4mbOJNTtPkISH10
         3Abp1m6Efbj6sDRc772JG/zlrCpmsVzGyNCy/hh+cpMJojHItRwNAgVJg7wseB9nxR23
         yBlw==
X-Gm-Message-State: AOJu0Yzm92+4FgspF1Nl1dXNYLRRdD+9+77QKBNDsy8oGrn7BCwMxBOT
	ts4JCYesl/ZrrJNz5oIhm7jyPC9GsbU+G38pghBgnm3TC9trrO69Tyltvm7/n8zkHDTC3YpXqqD
	Rnw5QEyTg4YVg1oUNqyYyoIXdg913QJ8VNxwaGA==
X-Google-Smtp-Source: AGHT+IGNMCtOBsrliO9IJvaCQ6wIStKn5JD0Sq28btLAoWmRi2uv8fOhNsIWgC6FelvmFneU7EPoXWCxrHsxLD9PCiw=
X-Received: by 2002:a0d:db55:0:b0:5e9:fa4a:fd56 with SMTP id
 d82-20020a0ddb55000000b005e9fa4afd56mr3217496ywe.13.1705936931753; Mon, 22
 Jan 2024 07:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-topic-rpmpd_cleanup-v1-1-860ab141b076@linaro.org>
In-Reply-To: <20231227-topic-rpmpd_cleanup-v1-1-860ab141b076@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:35 +0100
Message-ID: <CAPDyKFoMdhNeq22Ji9UZdZ5Ut536q6PGn6EBBVquV-nTW2FqoA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmpd: Keep one RPM handle for all RPMPDs
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Dec 2023 at 02:20, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> For no apparent reason (as there's just one RPM per SoC), all RPMPDs
> currently store a copy of a pointer to smd_rpm. Introduce a single,
> global one to save up on space in each definition.
>
> bloat-o-meter reports:
>
> Total: Before=92010, After=91062, chg -1.03%
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/rpmpd.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
> index 7796d65f96e8..90b62767f9d0 100644
> --- a/drivers/pmdomain/qcom/rpmpd.c
> +++ b/drivers/pmdomain/qcom/rpmpd.c
> @@ -16,6 +16,8 @@
>
>  #define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
>
> +static struct qcom_smd_rpm *rpmpd_smd_rpm;
> +
>  /* Resource types:
>   * RPMPD_X is X encoded as a little-endian, lower-case, ASCII string */
>  #define RPMPD_SMPA 0x61706d73
> @@ -54,7 +56,6 @@ struct rpmpd {
>         bool enabled;
>         const int res_type;
>         const int res_id;
> -       struct qcom_smd_rpm *rpm;
>         unsigned int max_state;
>         __le32 key;
>         bool state_synced;
> @@ -879,7 +880,7 @@ static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
>                 .value = cpu_to_le32(enable),
>         };
>
> -       return qcom_rpm_smd_write(pd->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
> +       return qcom_rpm_smd_write(rpmpd_smd_rpm, QCOM_SMD_RPM_ACTIVE_STATE,
>                                   pd->res_type, pd->res_id, &req, sizeof(req));
>  }
>
> @@ -891,7 +892,7 @@ static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
>                 .value = cpu_to_le32(corner),
>         };
>
> -       return qcom_rpm_smd_write(pd->rpm, state, pd->res_type, pd->res_id,
> +       return qcom_rpm_smd_write(rpmpd_smd_rpm, state, pd->res_type, pd->res_id,
>                                   &req, sizeof(req));
>  };
>
> @@ -1004,12 +1005,11 @@ static int rpmpd_probe(struct platform_device *pdev)
>         int i;
>         size_t num;
>         struct genpd_onecell_data *data;
> -       struct qcom_smd_rpm *rpm;
>         struct rpmpd **rpmpds;
>         const struct rpmpd_desc *desc;
>
> -       rpm = dev_get_drvdata(pdev->dev.parent);
> -       if (!rpm) {
> +       rpmpd_smd_rpm = dev_get_drvdata(pdev->dev.parent);
> +       if (!rpmpd_smd_rpm) {
>                 dev_err(&pdev->dev, "Unable to retrieve handle to RPM\n");
>                 return -ENODEV;
>         }
> @@ -1039,7 +1039,6 @@ static int rpmpd_probe(struct platform_device *pdev)
>                         continue;
>                 }
>
> -               rpmpds[i]->rpm = rpm;
>                 rpmpds[i]->max_state = desc->max_state;
>                 rpmpds[i]->pd.power_off = rpmpd_power_off;
>                 rpmpds[i]->pd.power_on = rpmpd_power_on;
>
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20231227-topic-rpmpd_cleanup-2e043dac9f47
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>

