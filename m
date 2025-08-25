Return-Path: <linux-pm+bounces-32968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2250BB335BB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 07:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19CC3B8F22
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 05:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C762765CE;
	Mon, 25 Aug 2025 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC0N59A3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85785275B02;
	Mon, 25 Aug 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756098552; cv=none; b=gv3v/sXqhZWJWBEwi+nqEAm/FgKEdMvHELwo3/Qw9G7HsCgpjRBo62jvz8ah+Q6kOAsU/LvwILUfKv4hFQEgmqwSwIOECTLwJppVaDE+BREGMQ6/ExDNQsttEkEUaOJd2vIu53StEP4hK8VuVQamhk5AQcrG8A4IUb62dkL2zbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756098552; c=relaxed/simple;
	bh=1uJice8br01BkTiuQekIrMsfPZnUu0D+eLpSKKOleXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dObhsr9L+SdXteIUvJ/oiLBIXuvPHyV2Fja7g1pJBobJcDYvl6nxkzzqPddFtzjYYmJDwddONpYCHGd/ZWuFQ0EimbbreMlBCn/0wBL9pkiE+G2t5gzkGTTp2n4vH5xAiWQAdJOhzqMgTE2Nt3E8mwAgrht/sjBB1MycuxfL8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC0N59A3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f3e4dfcf6so1289125e87.2;
        Sun, 24 Aug 2025 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756098549; x=1756703349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dEYCRBIfzdjyilnzYYyVa5HHYVB6VpdJNBknJaYwys=;
        b=TC0N59A38/XXCbudAlWNuQAkwjjXc1wzUqdc4YqkZkMS94VJT0JEU0Kiy2sFdsP77i
         3Qo5k3vJuLGGm0dqIY0A1sWXnKMamseCmTwYfu7ymq//EuuvIyqav7k1WobPETxUjJO9
         S7gKMdLW1fosVw7Ya7hkczTRNSKBKR/RJFQzx3yeFtXLQoQnEX4UagBHkN1rm5KYSIGj
         mR5FmGWNCYN91MVVdItSQXVQ1FSKtxAnHunRmd9LCK4RlGF1blnA0Itax5SoACZoKS0Q
         HOFdA/osh7+z7XDtOnWfQz9kaQjAEoUtyION+RvY0oWtHoWhljVzHewbVRAQI+HJrd+Z
         CqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756098549; x=1756703349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dEYCRBIfzdjyilnzYYyVa5HHYVB6VpdJNBknJaYwys=;
        b=ZD54KpnPBSH11l7zjkjGxnu+wvDRXrkFOtUH+BmoVWD2eZIiWRFLrBkORN0mIKoWk1
         lDjihvwNWt6UKFhbh91oNn9V+XwOXomCeE+qmOcf4/VLhYtngxjv7yLaYw954eQDtJJM
         6+2Vvb1VR+HbbeCkFRx5+3Ck01wpYDkrSk/aqNuZg/WHn7z81NuwHNZT7yX9FRNnyVEf
         IcJd7izJiU48SczkZvrwsF2nxFp+BwR+qWnQHUIs8HougZkphfEZjvURp79qxTkQq6FT
         m+cduYiN8I0mbcrvFzdBtvKY9KWeHyUmkWoaowDpKDbydoB2wajxon1jZmXN9TXEZjjg
         U0KA==
X-Forwarded-Encrypted: i=1; AJvYcCUhi2OV/bFWOHpNZ5TsMSzXAjsH13+qYwAvTuddapAafN6LwEgPvIkMtkRvPcllzd83jMROatfZVT0CAKU=@vger.kernel.org, AJvYcCVd47T8/canY0iIzRQ5FGyAv/4sB/v4ajubT1f/IfjNUsvJRnqrgK2DowNmlcW7f+MMZu9Qh6ks9Lg=@vger.kernel.org, AJvYcCWvPrNXR05qw3EdQKEUnMDrw5DPe6e5uHQu8x/bLyB7xeZ3W1pkdsFg49iklte+lg1yNoIVdzZDMppPntE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP93DsGTFAzq1a3OwkH7T7Eh7DxvH8N740Y+GH+AxYmGhQH4eV
	8/0Vxd8VvpdC3vDhq4IjYyvR80phPC+JqRRB2mIpkv99vFp8g01uitHsJXjJOrV8H421zjbV/Uj
	D3xGE2+AE6jAU/aj2IKrwNIA5tbLkF0w=
X-Gm-Gg: ASbGncvkjhuj3iwx/qvOf4W/k/eXOKTT5ULoEE6uuw0fPjh4qQYHEHWNyKK5D8ZrBJk
	l2zdJBLTVhQc0kBrOA2kSYwpbIWn5hZQ6DmBJvNHUwmsRYdPnJ1AWoDFm0an97TNsvwGNnSKTwf
	eV8qSWW7NRTG+Cw55OuOsUs+DILakOIzPR9VDlSzSYTzumyl4SlYVB7HGkhGlnZZCdRzsWKed0j
	6or0mw=
X-Google-Smtp-Source: AGHT+IEI/HL2SN5KRnSIHfB1+AmhdompV8QBzux+4Guzx5pKpn9u79V6BvppUlNlCHF3TiMwqjz7ppyhxy+lfKX9dzc=
X-Received: by 2002:a05:6512:660a:b0:55b:898c:7237 with SMTP id
 2adb3069b0e04-55f0ccbf169mr3099129e87.16.1756098548376; Sun, 24 Aug 2025
 22:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-tegra186-cpufreq-ndiv-v1-1-4669bf8f2992@gmail.com>
In-Reply-To: <20250825-tegra186-cpufreq-ndiv-v1-1-4669bf8f2992@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 25 Aug 2025 00:08:55 -0500
X-Gm-Features: Ac12FXynTjYSL35rstMis23JAF-IHG0or6xoTVzNGwuk4Stv-1CRGZaodUj4eNA
Message-ID: <CALHNRZ8oaGaAhMVVzfeNf+M+-OvMnCnMd-fRdffmOSTBZiEXCQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: tegra186: Default divider to 35 if register read fails
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:03=E2=80=AFAM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> Several of the cores fail to read any registers and thus fail to
> initialize cpufreq. With shared policies, this only affects the Denver
> cluster, but one of the A57 cores also exhibits this behaviour. If the
> value is initialized to match what is read by the downstream vendor
> kernel, scaling works as expected. I have never seen this value be
> anything other than 35, so it should be a relatively safe assumption.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra18=
6-cpufreq.c
> index cbabb726c6645d2e5f1857a47e5643c8552d1933..f017f903c6843f1881e831175=
3f6269637c6bc69 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -115,6 +115,11 @@ static unsigned int tegra186_cpufreq_get(unsigned in=
t cpu)
>
>         edvd_offset =3D data->cpus[policy->cpu].edvd_offset;
>         ndiv =3D readl(data->regs + edvd_offset) & EDVD_CORE_VOLT_FREQ_F_=
MASK;
> +       if (ndiv =3D=3D 0) {
> +               dev_warn_once(get_cpu_device(policy->cpu),
> +                        "Scaling registers invalid, using expected value=
s");
> +               ndiv =3D 35;
> +       }
>         cluster_id =3D data->cpus[policy->cpu].bpmp_cluster_id;
>         cluster =3D &data->clusters[cluster_id];
>         cpufreq_cpu_put(policy);
>
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250824-tegra186-cpufreq-ndiv-bc97a22814a9
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>

I tried to open a discussion about this issue on the mailing list [0],
but well over two months later, no responses have been given. I know
this isn't an ideal solution, but in lieu of better knowledge of
what's happening, this is the best I have. And this unblocks scaling
the denver cores on tegra186.

Aaron

[0] https://lore.kernel.org/linux-tegra/CALHNRZ98_gh5dKw_GoayG4ieU3TWYAFFt2=
9=3D495g4+dNLzwjbg@mail.gmail.com/

