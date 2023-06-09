Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6D729D63
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbjFIOx4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jun 2023 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbjFIOxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2023 10:53:55 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DE2D6B
        for <linux-pm@vger.kernel.org>; Fri,  9 Jun 2023 07:53:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565cd2fc9acso17401127b3.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2023 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322432; x=1688914432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crfoqQSmAhGzomMx3zCF66FDgyFADMORqZ73dTjvTwk=;
        b=uXmI4co4Cq/RILvFCa1kMrnCYDn4YAYYbA2W68xOo8vDNsfYOiYjWD99Yt69qdF+at
         9jIhGjBfe1uk8aOfeyTbVMRRDsk2J1jgvNZlM4KDIkM5E9HfN/Xq+wb9KI08n4/H/PtB
         agjD/D+KmbOvHUkP/WJWog+ULLcvRFQ3sOwblikbvzc9MKqcxxrTaH9XVwNB1c015cE0
         R9y+L1IpkZ0yPBNOU/M79WRrUMlSn7GxKuJEoduLumm9Ut5wGrw8AKneEuiV6K3rtJjc
         b/1gt78BkpjeVJdqwjdYA0PiNj31ghbHh1WrVsMQeu15EnU5jnTOsnwnM7DGmBlhA6n7
         k1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322432; x=1688914432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crfoqQSmAhGzomMx3zCF66FDgyFADMORqZ73dTjvTwk=;
        b=e0BnoWkOuz2h39y/vOaMv/GA7CGeHS4haOkKsUEeSzSkpEestOc/Q6mfyMT04zDlzJ
         DZgizCZWlxWyj/C3jskZC+0ufArg8PkIZ6MXL3R5JixhqTupJvMm3yr0LPMvLL1U12nz
         Qef+21mNK3w9M4eTYGHgP+ABB5JX+WoLGymC3hUGVO8TGVugNaQBuqbi+AFD8qIdp45w
         6zyV5GfS2PkWGQf1IZpFApsvpFcNC7QrhJaw3gBSx8OKxNLfdCUJguKwJ46GOnNWDMbu
         8Pn923UFHkKq++ijrijNPd2WTjZHeNui67nkrZTFtVmca2e56XNJu4ZJ9haIiOBNzcjA
         32iQ==
X-Gm-Message-State: AC+VfDwZ2OaTNaNrSCe0PNYVpg1TdiWTB0eawstnn4ebCJ3mL0BrKtNO
        oavyKOqwM7dTyTKcuFaF0FQcW5M8SlRlTCz4GxStMA==
X-Google-Smtp-Source: ACHHUZ5Zvmq0G1U7UDiYpltiUkNIfwZIqGHMg8ZTyTN2OiH8S6VtqneB0H22uzIjs2sE+7VQOtDPDcDCoeMKI1C8wWc=
X-Received: by 2002:a0d:d241:0:b0:55a:5ce4:aff2 with SMTP id
 u62-20020a0dd241000000b0055a5ce4aff2mr1435776ywd.39.1686322431888; Fri, 09
 Jun 2023 07:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230530165807.642084-1-robimarko@gmail.com> <20230530165807.642084-2-robimarko@gmail.com>
 <3f1bfaf9-35ff-59ae-6756-84fc8900ed92@linaro.org> <647708e2.050a0220.514c7.feab@mx.google.com>
 <517f8b82-1230-985a-811a-2100f0dd339e@linaro.org> <6483353e.7b0a0220.65698.0e15@mx.google.com>
In-Reply-To: <6483353e.7b0a0220.65698.0e15@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 9 Jun 2023 17:53:40 +0300
Message-ID: <CAA8EJpqCiWFxVSbMLViJaVvAqVVu9Tx6SAUovDH9GraeTYH4HA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for IPQ8064
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 9 Jun 2023 at 17:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Thu, Jun 01, 2023 at 06:07:17PM +0300, Dmitry Baryshkov wrote:
> > On 31/05/2023 04:36, Christian Marangi wrote:
> > > On Wed, May 31, 2023 at 05:03:01AM +0300, Dmitry Baryshkov wrote:
> > > > On 30/05/2023 19:58, Robert Marko wrote:
> > > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > >
> > > > > IPQ8064 comes in 3 families:
> > > > > * IPQ8062 up to 1.0GHz
> > > > > * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> > > > > * IPQ8065/IPQ8069 up to 1.7Ghz
> > > > >
> > > > > So, in order to be able to share one OPP table, add support for
> > > > > IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
> > > > > IPQ8064.
> > > > >
> > > > > Bit are set with the following logic:
> > > > > * IPQ8062 BIT 0
> > > > > * IPQ8064/IPQ8066/IPQ8068 BIT 1
> > > > > * IPQ8065/IPQ8069 BIT 2
> > > > >
> > > > > speed is never fused, only psv values are fused.
> > > > > Set speed to the versions to permit a unified opp table following
> > > > > this named opp:
> > > > >
> > > > > opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0
> > > > >
> > > > > Example:
> > > > > - for ipq8062 psv2
> > > > >     opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
> > > > > - for ipq8064 psv2
> > > > >     opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
> > > > > - for ipq8065 psv2
> > > > >     opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
> > > > >
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > > ---
> > > > >    drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
> > > > >    1 file changed, 72 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > index ce444b5962f2..c644138680ba 100644
> > > > > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > > > > @@ -34,6 +34,10 @@
> > > > >    #define IPQ8074_HAWKEYE_VERSION              BIT(0)
> > > > >    #define IPQ8074_ACORN_VERSION                BIT(1)
> > > > > +#define IPQ8062_VERSION                BIT(0)
> > > > > +#define IPQ8064_VERSION                BIT(1)
> > > > > +#define IPQ8065_VERSION                BIT(2)
> > > >
> > > > I think it would be more logical to change these defines to consecutive enum
> > > > instead of BIT(n) values. Another (and better in my opinion) option is to
> > > > drop versions completely (and remove speedN from the opp names) and to have
> > > > per-SoC tables in per-SoC dtsi files. There are already separate
> > > > ipq8064.dtsi, ipq8062.dtsi and ipq8065.dtsi files. It makes little sense to
> > > > overcomplicate the OPP tables.
> > > >
> > >
> > > That is what was used downstream but it was also wrong and against the
> > > normal implementation of this driver itself.
> > >
> > > OPP have opp-supported-hw just for the task with the principle of
> > > declaring a single table in dtsi and automatically select the right one.
> > >
> > > Using the implementation downstream (opp table in each dtsi) is actually
> > > worse as ipq8065 have 1.4ghz and not 1.2ghz and that can correctly be
> > > handled with opp-supported-hw (and this change) or using delete-property
> > > in dtsi (that I don't really like and it's ugly)
> > >
> > > Also this implementation would match what is currently secribed for the
> > > use of OPP in the documentation.
> > >
> > > Hope you can understand the reason of this change, the intention is to
> > > clear and trying to use standard OPP stuff instead of hacks in the DTS.
> >
> > I'm fine with the opp-supported-hw part (I forgot that it is used by default
> > with the help of drv->versions). I do not like the idea of encoding the same
> > value into the -speedN part. If it is not needed, it's better be dropped
> > than using a semi-dummy value there.
> >
> > So, I'd suggest to define an enum, use BIT(enum_value) for drv->versions and
> > drop the speed%d part.
> >
> > Also, while we are at it, could you please define a schema for your opp
> > extensions? An example would make it easier to understand the bindings (and
> > will also provide a reference for possible other implementers).
> >
>
> Sorry for the delay in answering this.
>
> The speed part is still needed... since the voltage for each voltage
> change on the different SoC.
>
> Let me give you an example for one freq.
>
>                 opp-384000000 {
>                         opp-hz = /bits/ 64 <384000000>;
>                         opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
>                         opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
>                         opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
>                         opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
>                         opp-microvolt-speed2-pvs0-v0 = <1000000 950000 1050000>;
>                         opp-microvolt-speed2-pvs1-v0 = <925000 878750 971250>;
>                         opp-microvolt-speed2-pvs2-v0 = <875000 831250 918750>;
>                         opp-microvolt-speed2-pvs3-v0 = <800000 760000 840000>;
>                         opp-microvolt-speed4-pvs0-v0 = <975000 926250 1023750>;
>                         opp-microvolt-speed4-pvs1-v0 = <950000 902500 997500>;
>                         opp-microvolt-speed4-pvs2-v0 = <925000 878750 971250>;
>                         opp-microvolt-speed4-pvs3-v0 = <900000 855000 945000>;
>                         opp-microvolt-speed4-pvs4-v0 = <875000 831250 918750>;
>                         opp-microvolt-speed4-pvs5-v0 = <825000 783750 866250>;
>                         opp-microvolt-speed4-pvs6-v0 = <775000 736250 813750>;
>                         opp-supported-hw = <0x7>;
>                         clock-latency-ns = <100000>;
>                 };

What about (it will require changes to opp-v2-base.yaml):

opp-384000000-0 {
    opp-hz = /bits/ 64 <384000000>;
    opp-microvolt-pvs0-v0 = <1000000 950000 1050000>;
    opp-microvolt-pvs1-v0 = <925000 878750 971250>;
    opp-microvolt-pvs2-v0 = <875000 831250 918750>;
    opp-microvolt-pvs3-v0 = <800000 760000 840000>;
    opp-supported-hw = <0x1>;
    clock-latency-ns = <100000>;
};

opp-384000000-1 {
    opp-hz = /bits/ 64 <384000000>;
    opp-microvolt-pvs0-v0 = <1000000 950000 1050000>;
    opp-microvolt-pvs1-v0 = <925000 878750 971250>;
    opp-microvolt-pvs2-v0 = <875000 831250 918750>;
    opp-microvolt-pvs3-v0 = <800000 760000 840000>;
   opp-supported-hw = <0x2>;
    clock-latency-ns = <100000>;
};

opp-384000000-2 {
    opp-hz = /bits/ 64 <384000000>;
    opp-microvolt-pvs0-v0 = <975000 926250 1023750>;
    opp-microvolt-pvs1-v0 = <950000 902500 997500>;
    opp-microvolt-pvs2-v0 = <925000 878750 971250>;
    opp-microvolt-pvs3-v0 = <900000 855000 945000>;
    opp-microvolt-pvs4-v0 = <875000 831250 918750>;
    opp-microvolt-pvs5-v0 = <825000 783750 866250>;
    opp-microvolt-pvs6-v0 = <775000 736250 813750>;
    opp-supported-hw = <0x4>;
    clock-latency-ns = <100000>;
};


> As you can see we use the speed value to match the different SoC and
> apply the correct voltage.
>
> Yes I will add the missing info in the schema.
>
> > >
> > > > > +
> > > > >    struct qcom_cpufreq_drv;
> > > > >    struct qcom_cpufreq_match_data {
> > > > > @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> > > > >         return ret;
> > > > >    }
> > > > > +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> > > > > +                                            struct nvmem_cell *speedbin_nvmem,
> > > > > +                                            char **pvs_name,
> > > > > +                                            struct qcom_cpufreq_drv *drv)
> > > > > +{
> > > > > +       int speed = 0, pvs = 0, pvs_ver = 0;
> > > > > +       int msm_id, ret = 0;
> > > > > +       u8 *speedbin;
> > > > > +       size_t len;
> > > > > +
> > > > > +       speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> > > > > +
> > > > > +       if (IS_ERR(speedbin))
> > > > > +               return PTR_ERR(speedbin);
> > > > > +
> > > > > +       switch (len) {
> > > > > +       case 4:
> > > > > +               get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
> > > > > +                                      speedbin);
> > > > > +               break;
> > > > > +       default:
> > > > > +               dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> > > > > +               ret = -ENODEV;
> > > > > +               goto len_error;
> > > > > +       }
> > > > > +
> > > > > +       ret = qcom_smem_get_soc_id(&msm_id);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       switch (msm_id) {
> > > > > +       case QCOM_ID_IPQ8062:
> > > > > +               drv->versions = IPQ8062_VERSION;
> > > > > +               break;
> > > > > +       case QCOM_ID_IPQ8064:
> > > > > +       case QCOM_ID_IPQ8066:
> > > > > +       case QCOM_ID_IPQ8068:
> > > > > +               drv->versions = IPQ8064_VERSION;
> > > > > +               break;
> > > > > +       case QCOM_ID_IPQ8065:
> > > > > +       case QCOM_ID_IPQ8069:
> > > > > +               drv->versions = IPQ8065_VERSION;
> > > > > +               break;
> > > > > +       default:
> > > > > +               dev_err(cpu_dev,
> > > > > +                       "SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> > > > > +                       msm_id);
> > > > > +               drv->versions = IPQ8062_VERSION;
> > > > > +               break;
> > > > > +       }
> > > > > +
> > > > > +       /*
> > > > > +        * IPQ8064 speed is never fused. Only psv values are fused.
> > > > > +        * Set speed to the versions to permit a unified opp table.
> > > > > +        */
> > > > > +       snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> > > > > +                drv->versions, pvs, pvs_ver);
> > > > > +
> > > > > +len_error:
> > > > > +       kfree(speedbin);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > >    static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> > > > >                                              struct nvmem_cell *speedbin_nvmem,
> > > > >                                              char **pvs_name,


-- 
With best wishes
Dmitry
