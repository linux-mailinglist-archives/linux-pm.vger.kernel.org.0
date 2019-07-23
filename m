Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E97271A9B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbfGWOmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:42:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36338 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732837AbfGWOmt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 10:42:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so20714416plt.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=MivtH/AFd/UEBQTX1L8TkdX1tWBHqaY6Yrp0reG3yuY=;
        b=F6O53VjEkHgJGSFWE/TyGmcDrTX0Wb2ZnWmoEgoElaJLQk0ljUEFxCdRC8tslzbYSO
         OfVlVRNf1LgjAQ48ihB/FvdgfcuibxsMHLeZl2DqLHBiRRH/BmXEPvdXmeNHyorYgwQo
         EvgECRgKQF92fVGNnSgLG06OLJ3lZh/arI5+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=MivtH/AFd/UEBQTX1L8TkdX1tWBHqaY6Yrp0reG3yuY=;
        b=JR7EH8Mr2arr6wJY+bEpIhXbdEHsCWez6GFupYBGnqYHBhcA0eRHQGMY/cLwAA5Fx4
         jQSX7mnbDLh2IqDz77EyLNFDm+HZXfpH5/SFdhDAhPF2u4UfDlGRByralVqu5SYoaxRP
         8torjfsqGdbjots18oCxSoGhyZb80asphkIK9OL/jyypORuSdc44P2RUssDzfTD/ISFH
         RLBxrK01fZvQEgLjB2q2QyOESOaWqUVo4Rj2/sdUAhUMb7oyL2XVLyYZ+YeQC9rS6+Tx
         EKKhT/CTDUoNI7ZeqT1ZFMTzkYx1rYrRRxMH8UBqkYJEA6vtK5TjsWktlfYluSIljSP+
         JdYg==
X-Gm-Message-State: APjAAAXQzWrkpcjGtuS5TMamSBJHVQ6wothbXcGfAzCCJQ45AvWR9cHF
        AAmv+/2nU0JonldQeAMNOzMo3A==
X-Google-Smtp-Source: APXvYqwtTx+QcAkXyfMl6NVacF5zqtkUSMrP0EzvRLV+pzVxCuifqK7xZtp+fixLQIdo1o6i/27a2A==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr82515691plo.88.1563892968559;
        Tue, 23 Jul 2019 07:42:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a6sm40156512pfa.162.2019.07.23.07.42.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:42:47 -0700 (PDT)
Message-ID: <5d371ce7.1c69fb81.9650.8239@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org> <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
To:     David Dai <daidavid1@codeaurora.org>, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, evgreen@google.com,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 07:42:46 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting David Dai (2019-07-19 13:32:23)
> Redefine the Network-on-Chip devices to more accurately describe
> the interconnect topology on Qualcomm's SDM845 platform. Each
> interconnect device can communicate with different instances of the
> RPMh hardware which are described as RSCs(Resource State Coordinators).
>=20
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-vote=
r.txt b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
> new file mode 100644
> index 0000000..2cf7da2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
> @@ -0,0 +1,32 @@
> +Qualcomm BCM-Voter interconnect driver binding
> +-----------------------------------------------------------
> +
> +The Bus Clock Manager (BCM) is a dedicated hardware accelerator
> +that manages shared system resources by aggregating requests
> +from multiple Resource State Coordinators (RSC). Interconnect
> +providers are able to vote for aggregated thresholds values from
> +consumers by communicating through their respective RSCs.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +                       "qcom,sdm845-bcm-voter",
> +
> +Examples:
> +
> +apps_rsc: rsc@179c0000 {

But there isn't a reg property.

> +       label =3D "apps_rsc";

Is label required?

> +       compatible =3D "qcom,rpmh-rsc";
> +
> +       apps_bcm_voter: bcm_voter {
> +               compatible =3D "qcom,sdm845-bcm-voter";
> +       };
> +}
> +
> +disp_rsc: rsc@179d0000 {
> +       label =3D "disp_rsc";
> +       compatible =3D "qcom,rpmh-rsc";
> +
> +       disp_bcm_voter: bcm_voter {
> +               compatible =3D "qcom,sdm845-bcm-voter";
> +       };
> +}
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.t=
xt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> index 5c4f1d9..27f9ed9 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> @@ -4,21 +4,43 @@ Qualcomm SDM845 Network-On-Chip interconnect driver bin=
ding
>  SDM845 interconnect providers support system bandwidth requirements thro=
ugh
>  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provide=
r is
>  able to communicate with the BCM through the Resource State Coordinator =
(RSC)
> -associated with each execution environment. Provider nodes must reside w=
ithin
> -an RPMh device node pertaining to their RSC and each provider maps to a =
single
> -RPMh resource.
> +associated with each execution environment. Provider nodes must point to=
 at
> +least one RPMh device child node pertaining to their RSC and each provid=
er
> +can map to multiple RPMh resources.
> =20
>  Required properties :
>  - compatible : shall contain only one of the following:
> -                       "qcom,sdm845-rsc-hlos"
> +                       "qcom,sdm845-aggre1_noc",
> +                       "qcom,sdm845-aggre2_noc",
> +                       "qcom,sdm845-config_noc",
> +                       "qcom,sdm845-dc_noc",
> +                       "qcom,sdm845-gladiator_noc",
> +                       "qcom,sdm845-mem_noc",
> +                       "qcom,sdm845-mmss_noc",
> +                       "qcom,sdm845-system_noc",
>  - #interconnect-cells : should contain 1
> +- reg : shall contain base register location and length
> +- qcom,bcm-voter : shall contain phandles to bcm voters
> =20
>  Examples:
> =20
> -apps_rsc: rsc {
> -       rsc_hlos: interconnect {
> -               compatible =3D "qcom,sdm845-rsc-hlos";
> -               #interconnect-cells =3D <1>;
> -       };
> +aggre1_noc: interconnect@16e0000 {
> +       compatible =3D "qcom,sdm845-aggre1_noc";
> +       reg =3D <0x16e0000 0xd080>;
> +       interconnect-cells =3D <1>;
> +       qcom,bcm-voter =3D <&apps_bcm_voter>;
>  };
> =20
> +mmss_noc: interconnect@1740000 {
> +       compatible =3D "qcom,sdm845-mmss_noc";
> +       reg =3D <0x1740000 0x1c1000>;
> +       interconnect-cells =3D <1>;
> +       qcom,bcm-voter =3D <&apps_bcm_voter>, <&disp_bcm_voter>;
> +};
> +
> +mem_noc: interconnect@1380000 {
> +       compatible =3D "qcom,sdm845-mem_noc";
> +       reg =3D <0 0x1380000 0 0x27200>;
> +       #interconnect-cells =3D <1>;
> +       qcom,bcm-voter =3D <&apps_bcm_voter>, <&disp_bcm_voter>;
> +};

How does a consumer target a particular RSC? For example, how can
display decide to use the disp_bcm_voter node from mem_noc here? Maybe
you can add that consumer to the example?

