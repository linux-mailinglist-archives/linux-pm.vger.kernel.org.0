Return-Path: <linux-pm+bounces-40133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D1CEED3F
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3108B300B807
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E7025487C;
	Fri,  2 Jan 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSuVqOI2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FXZvJXOo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F39247295
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366604; cv=none; b=Pa7rnAb7gDHlHTQieH+6KSvl0lWiQR93y4VM0ymwcqpJft55Ue8n0JeKDCH0UBduOB4+zxQlbQz88wui9fR62WeNAj4yuXRD5o45uW9OnaVeMo+ESxCS7ixC1PYYW803ulpRGrdoBcZLEddJXffy1T5Bnn9GxWYw1lEyuteSN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366604; c=relaxed/simple;
	bh=YLwHLy1IcBzzjaKusaPLSAROyh/EgP17TAh1ILt/VX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVX7ef8gEdttXiLu0M4hXNDmpfvLTd7f3IDcFGNNNNjnej9Tag+GFlV1KKuu9Urqvxo3JTnn/qPnU1fTaqTKFmIXLRlSi+LcTsvnNTfHgXiB7dWyK0pLWpNQPeDtQrpaJ2P8TBWPERwVVIADTJMigbl1xvK32kj1Ao2yiULt4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSuVqOI2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FXZvJXOo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WF9e427436
	for <linux-pm@vger.kernel.org>; Fri, 2 Jan 2026 15:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UI4UX8qD/+Ay11IN6HqXBJhwTeU0IQ4j0jQA2/n/Yys=; b=QSuVqOI2SkLa2AkB
	OlWYdrD/b8IlQ+fyqPyI/ClV9ZL3yNS1TH0hEl90pqKDBJfQtnZsOAqXkfc1smT4
	4GZv/w5RxExXdlUDgSVG4AGR08MrwZzpdeZ1b37a6k/huTfwmj+Xl302zFatSEOi
	16J+LtKXwT2ikUjEroiPENkDADRH07FCQv2U9HuBkPA0ncXz6sujIWyu412PCvAR
	8efkCiTfpluUtqZLliB8HZRKujUke6nsCraVhnZ0LdUxpBycM4qFiab3mAV4fKlH
	yxcHUfKbIboJL1lCdwCU621PKve3YYRchiE0RzcwHfhLXlALBmGYRLLP6oFPmT5S
	eFrISw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4be6fjs6yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 15:10:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34e5a9de94bso26296837a91.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767366602; x=1767971402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI4UX8qD/+Ay11IN6HqXBJhwTeU0IQ4j0jQA2/n/Yys=;
        b=FXZvJXOofHmA5BP++qXOcPFAXzeN3QDvC+YCe7600+Bf4hHtY+mRx0DYsB49aWxq9R
         08+LrUhzj9pPv/76VzbwVjDFG3W/PxVxM+HyXBinICtEFdB498io6z5A6msnwwWv2OJh
         YuTlvdvDVgj/LfpfeuREBfRuPrDiCmvkuie2M59n5sY6vXkyfW0PsNMTzud3GfnIRB9+
         6mKX3B5OgoAbhpTedg1D5xPvvqwFZEENmy4wkQ1ROwjCVCdnFVXLF33CvVDYFZKziARE
         UA1g3e/r0+g0ECntsE/YG1Ykz4uXBBljupCav8le92zDBubVFhAcb1LH0RJjz3lRjTar
         s7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767366602; x=1767971402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UI4UX8qD/+Ay11IN6HqXBJhwTeU0IQ4j0jQA2/n/Yys=;
        b=hcVN1Zqth4XHexreDrsVl23g1iS9LmbtHqJ7DqqxOZHJSLmMFary9Qr+N8TopJiQVz
         pVl7qGXmcxajF3dcs+RlhLGWcD2tvItbMq0L6tKhFhvchb0xTJaDKI974L2L3lc6Sf17
         +T6ZmILvDEIeZuvCqhg61iBd6EluAnIbqFwPHYzhKQSc3cjXtHKe3GmXUMv6RpXi5HIb
         VEJHe9vltspk4UTYie+Wdcy0HhUadNUjGb8uNtxRSl8cmGUkbl8jxeSx82wpWslbW2n9
         nqQNvaW3nZkCwvB92O09/Qzj22FSbfWxh1u3vPHjDi9TlQOhXdq9bRyvm3iU2r2C8H+C
         BLDg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Q+RoM/tWLiNp50mq1YR+2/PAW8SVpeuUOeJc2DanrK243G4HQFdhxVCPHJi3bvwnv5zcAPMXuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5mn4kD+tLnMwwkNxFLeGAwTH0X59dYhG6oDQDSBhMGJDqEDs
	Ja+eOPbgXY01pkpmUaoGk82bcmYXIUsdYxCN3GManNitATxmazs5d8Ul7oT/i5tEA1E3hvhTte5
	wdUBgeoaPcxfNJWmPpcKbWsWf43+0EBl8aFlqxxSIMyy04r+CR690LKFZQvTYcZNWof6L3L14/m
	vCFsDlhim2zhkYomGaBhs21eis5o6yPEgIKHPn
X-Gm-Gg: AY/fxX7LZf93tlD3JcOLP4z/IFR+BaQMcvu3xgVckUGrnttG5I8eiPY2dMZOq0sRFTG
	SRszhC8OUQdEKE4vsmoCs5NDelGTMFRlCPMUIR1oxoM94vJHz0M6mJaU7rTS+zEkX2PSxAvEkpg
	qPqb+JYh8selP/JGzTJmKC1kjpnxkBrelNcz9nm6qELTLIHyVmK3AVGs+P5Abr6122rBxa3cbcC
	J2jZGs1
X-Received: by 2002:a05:6a20:2446:b0:361:3bda:43aa with SMTP id adf61e73a8af0-376a81dc0d7mr38447959637.1.1767366601582;
        Fri, 02 Jan 2026 07:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXBHsj5HPlkrOf/QA7SEvXnhYeXLKX9eNIQ/Tk1248XeSURHeZEJfSWWPyXrvZvYck5Snp5pKIaVAPYzKALcI=
X-Received: by 2002:a05:6a20:2446:b0:361:3bda:43aa with SMTP id
 adf61e73a8af0-376a81dc0d7mr38447931637.1.1767366601013; Fri, 02 Jan 2026
 07:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-4-1ff4d6028ad5@oss.qualcomm.com> <CAMRc=Mey1ScNmosipLFg6mmABjeG2SO2L-pyjwTuOpOYOHZjqg@mail.gmail.com>
In-Reply-To: <CAMRc=Mey1ScNmosipLFg6mmABjeG2SO2L-pyjwTuOpOYOHZjqg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 17:09:52 +0200
X-Gm-Features: AQt7F2omVQ1MDvfoA-OCuHjJiLqz1Jf2o41fOPl5iwM5NSCJMu-v_c4lPrNQJlw
Message-ID: <CAO9ioeU2JjzDwkGQzxc963kakNyZCtaSRAmLu=1kOAMGQeuZRQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] wifi: ath10k: snoc: support powering on the device
 via pwrseq
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Av7jHe9P c=1 sm=1 tr=0 ts=6957dfca cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6Bc-fsn6kEsOX9bBnJcA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: sjdhDqms9a0ltsCDg13vMROTOxv4ImJf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEzNSBTYWx0ZWRfX8aI9wWcDQ9PJ
 QrpJkqBBKGbyDRkhk1rk6u8z1hKxAF/lat/oCfXtnUIG64Y6avoUB/UCgjeWyLDjXl0grSr/TQp
 ZewuI/GuT17bk9TtR+xwDXlPlcjxlhdhbsTqJ5aaNVcY/7wT3T7DG4uX+f9uFo6vDyZTE+EIsEY
 xME3sJzRxWWMAZ2svDgbC5tP50nfp4BjlC4tgWaMWIVF3zlgkZWNjT71eL8MF0wF1Xg6BFnub03
 SGyCXwSiG0nhyFnvz4dGfek8HqgzdeEZmrRJBI/PDE4N/ayWzarK+e5kG0srOPSymT0svShBJaw
 lRBwk+9IeX1M4DFfbXoQ17Nk+ENcTR9AgKoZnAFHcMGL/dhQbIbmCWyemm5mrbivrA1PAeBE/zH
 stQMD8BqgVQnb3nPhRLdhzaKBysxEnkRUdxF6ENZN0TXfTuZCUHtJrK+y8uobj6iE5ZTCgYL157
 bdxR1XudPxdLmyQ9YYg==
X-Proofpoint-GUID: sjdhDqms9a0ltsCDg13vMROTOxv4ImJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020135

On Fri, 2 Jan 2026 at 13:07, Bartosz Golaszewski <brgl@kernel.org> wrote:
>
> On Wed, Dec 31, 2025 at 12:36=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreadin=
g
> > voltages over internal rails. Implement support for using powersequence=
r
> > for this family of ATH10k devices in addition to using regulators.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
>
> [snip]
>
> >
> >  static void ath10k_snoc_wlan_disable(struct ath10k *ar)
> > @@ -1762,7 +1779,27 @@ static int ath10k_snoc_probe(struct platform_dev=
ice *pdev)
> >                 goto err_release_resource;
> >         }
> >
> > -       ar_snoc->num_vregs =3D ARRAY_SIZE(ath10k_regulators);
> > +       /*
> > +        * Backwards compatibility, ignore the defer error from pwrseq,=
 if it
> > +        * should be used, we will get an error from regulator get.
> > +        */
>
> Can you elaborate on this? I'm not exactly following. I suppose you
> mean the regulator_get() will return -EPROBE_DEFER? One of the
> supplies exposed by the PMU?

Yes. devm_pwrseq_get() can return -EPROBE_DEFER in two cases:
- it is not supposed to be used
- it is supposed to be used, but the driver hasn't probed yet.

There is no simple way to distinguish between these two cases, but:
- if it is not supposed to be used, then regulator_bulk_get() will
return all regulators as expected, continuing the probe
- if it is supposed to be used, but wasn't probed yet, we will get
-EPROBE_DEFER from regulator_bulk_get() too.

I can write that in a comment, if you think that it makes the code more obv=
ious.

>
> Bart
>
> > +       ar_snoc->pwrseq =3D devm_pwrseq_get(&pdev->dev, "wlan");
> > +       if (IS_ERR(ar_snoc->pwrseq)) {
> > +               ret =3D PTR_ERR(ar_snoc->pwrseq);
> > +               ar_snoc->pwrseq =3D NULL;
> > +               if (ret !=3D -EPROBE_DEFER)
> > +                       goto err_free_irq;
> > +
> > +               ar_snoc->num_vregs =3D ARRAY_SIZE(ath10k_regulators);
> > +       } else {
> > +               /*
> > +                * The first regulator (vdd-0.8-cx-mx) is used to power=
 on part
> > +                * of the SoC rather than the PMU on WCN399x, the rest =
are
> > +                * handled via pwrseq.
> > +                */
> > +               ar_snoc->num_vregs =3D 1;
> > +       }
> > +



--=20
With best wishes
Dmitry

