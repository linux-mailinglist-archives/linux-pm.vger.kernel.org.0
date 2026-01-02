Return-Path: <linux-pm+bounces-40120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E55CEE42F
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B62C30026A4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8042E11C7;
	Fri,  2 Jan 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRcvgxz0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C02E0926
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352053; cv=none; b=fbb+GZher4T1VIyc08xVzxKyWavtNiYArskbWKP2xGwTs5V+czb4DpRVBiv3/9mTZM6XVTBiKlTSLLnzhlhgTCtIraZMakCeKJ0p+izZU4PCoO8hh5jkkC79Uc7RjA2d64bgdzGL7JwgBJlugbjeLfQgWwufF8r4a1Vc2B8J9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352053; c=relaxed/simple;
	bh=F3aAq1jYJGU16fmEaHx+dz6wHtwN6K43frkZB/dF+gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXcr4USmmzJbIu2PmHTYxdx5MWZkLjb74YF0YjDrgF/tWWxfgaB4PlAJQ4P3SGtsMf1I0d/psR0l2hOtR53JC56ub2mOX2oF00zwgzzETkjytZscXYBpLIDdhXuFOTOzoMMSzVEtw924xhPrm/jqzbmnpM6gOcBJ7R9wY9NLtjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRcvgxz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F10AC19423
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767352053;
	bh=F3aAq1jYJGU16fmEaHx+dz6wHtwN6K43frkZB/dF+gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WRcvgxz0HW5gFOGurq0UpE0B0xN9dmpje2rYOOV+eVdNlar+kzozmxOt0Ua1hmz4v
	 I6+vSc9myTGMEag7+Y5IfHcmyAdB+eVmpsigJUVV0g1S2/iK8rQ9rcubKvJ1bVYFGx
	 ShnwRm4bPGAts6PUjA0jvw/Km6eYxe+nzYrnCW7H+Lg+o1pFKFY28yna5BxvQNqN1U
	 IiQpQmPsGB2zRCs2N6NBUhdn3ALVnN0DnhfCpmJ2oxBlpgLO0835VunD7lEzZytAfs
	 aD+ex8M5/e3hVB+tT3qQCDlh9OwPem9bCKgIH/ExynBraCDBtcA8CXKZ5jmJ214s7v
	 C4D+XHbXB3kUQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so77286431fa.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 03:07:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhzAv3M2IDYAy2u9Ofd4jIcXHrMCCXN/kJ2eamLwCWoOfOFiN55abhI1u1MWLgU3XkH/Joh4baBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V8C2Kl7ac8AGkZ0M7VCd8wysIgGzIQnnI/9L0jmg8Yt+pOY3
	tlfDSYOLYI5D4Pxd9X27Iuc8xNXtw5KOWz1Iunn7KS9ycs1XwMMkQ2PFBJ9m9LWS3Mdx2uBXV8R
	3/6nxPfPNQtD8uWunntsJlik48JrtEN4YtlcV7SWotg==
X-Google-Smtp-Source: AGHT+IECDXlql60R3DMIWp9kjLwxAHDu8fuxvKIOIfP1h3fonlqom3qIu6aeomXPr7jXdMs2XMEBzNiyaL5yGx8uDT0=
X-Received: by 2002:a05:651c:31dc:b0:372:8f0d:b0bc with SMTP id
 38308e7fff4ca-3812152aa1amr115769131fa.9.1767352051710; Fri, 02 Jan 2026
 03:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-4-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-4-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 12:07:19 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mey1ScNmosipLFg6mmABjeG2SO2L-pyjwTuOpOYOHZjqg@mail.gmail.com>
X-Gm-Features: AQt7F2qRiWiHXtdQFeT3NmxdPtGTuo9HGfYlrKz_4sHVMqf0-f-_Q9QRMBPkh4M
Message-ID: <CAMRc=Mey1ScNmosipLFg6mmABjeG2SO2L-pyjwTuOpOYOHZjqg@mail.gmail.com>
Subject: Re: [PATCH 04/14] wifi: ath10k: snoc: support powering on the device
 via pwrseq
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 12:36=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement support for using powersequencer
> for this family of ATH10k devices in addition to using regulators.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[snip]

>
>  static void ath10k_snoc_wlan_disable(struct ath10k *ar)
> @@ -1762,7 +1779,27 @@ static int ath10k_snoc_probe(struct platform_devic=
e *pdev)
>                 goto err_release_resource;
>         }
>
> -       ar_snoc->num_vregs =3D ARRAY_SIZE(ath10k_regulators);
> +       /*
> +        * Backwards compatibility, ignore the defer error from pwrseq, i=
f it
> +        * should be used, we will get an error from regulator get.
> +        */

Can you elaborate on this? I'm not exactly following. I suppose you
mean the regulator_get() will return -EPROBE_DEFER? One of the
supplies exposed by the PMU?

Bart

> +       ar_snoc->pwrseq =3D devm_pwrseq_get(&pdev->dev, "wlan");
> +       if (IS_ERR(ar_snoc->pwrseq)) {
> +               ret =3D PTR_ERR(ar_snoc->pwrseq);
> +               ar_snoc->pwrseq =3D NULL;
> +               if (ret !=3D -EPROBE_DEFER)
> +                       goto err_free_irq;
> +
> +               ar_snoc->num_vregs =3D ARRAY_SIZE(ath10k_regulators);
> +       } else {
> +               /*
> +                * The first regulator (vdd-0.8-cx-mx) is used to power o=
n part
> +                * of the SoC rather than the PMU on WCN399x, the rest ar=
e
> +                * handled via pwrseq.
> +                */
> +               ar_snoc->num_vregs =3D 1;
> +       }
> +

