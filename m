Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4849D950
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 00:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfHZWk1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 18:40:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43104 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHZWk1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 18:40:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id e12so16807690otp.10;
        Mon, 26 Aug 2019 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBtUgp09ILtLJx82v7/9S8a2bPggcu3SBMJmSRWkOWU=;
        b=q9KKwFI2spBd11DLhVGrnyWQ1itKWiJjNUpvQb1lcigAsiIa+zqXV82lgLULFRFzvY
         i/A5q06MVmhusfme0Ht+CbyPFuNMSHhcZYLY8I4jksbTYGpNIuOmgXorJ5KIDpiRD80d
         0zhLZqPjdoEjoVBAOLrpQMonWWoSoNqSpUUzUZBAm8wRtSHcdYw60KPG3ITSWALzqpTQ
         CEKoNBmEfKEjOnz2LA4YCMClL8//qfoXF7ybS3TZRxu+x2+AyvdmlGx5GAmhZ5KV5AbL
         1LCSqWmL7gpHIxS6ZfGtcF+QfQvgAeypN9W97aH7Zp97DKtIu6KdXpA6IwBYNPrKjm66
         Un+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBtUgp09ILtLJx82v7/9S8a2bPggcu3SBMJmSRWkOWU=;
        b=cdG1TRyBji80fNIZfDEbUJHsQaYRvrlJaHRMH0DaIMAGrlSV6aflYeC9HOa+e1cdvy
         FFECXjIX1c9abUz0jimiXbOASvra5Qllv2QQ/4MXH4tAHhowBavVc1jIHrCCSm03BI89
         DnzRFP321ZSNXPESbonG04+/BrZN4U+WgxnTDts03U/8T8Vrzs+MFHxhuSG5X+AlZxbc
         WyqDMdxQGg/TBgGqhVAr62Qv2KhzfYRu/LuL6kOqanMI0OX+IHHz79o8lALiJI/Ckk8u
         SCkFaGkOZbyCu+IpsSAlq6N6g2xJN80tQj48jN8TCDu+5DT5TPx5+OLsUVlpJSKieLPH
         mpDw==
X-Gm-Message-State: APjAAAVFaW7k6O/fDbhP04d7hXynDowLaTiUTp/rsOUBJ8mLYF99rlhV
        r1GMEaP+ormfvF6CCcT2OSazklgd/nsIKdgqETE=
X-Google-Smtp-Source: APXvYqz1tIwsKtjQUBPVQFswHzIWhO2ha2uKXMrM0jPjl6uCPWwQ2ehNr4SbBIrZI0zPPR9GJOgG6djB2Nf93UqVxso=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr16553944otj.96.1566859224972;
 Mon, 26 Aug 2019 15:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190823090418.17148-1-narmstrong@baylibre.com>
 <20190823090418.17148-3-narmstrong@baylibre.com> <CAFBinCBy-VxfSMPMR0cEDuNg8=UOUVvWfkDi2Tp=QhBZka93aQ@mail.gmail.com>
 <f6e7e4de-e1b7-f642-07cb-fa029ff2a883@baylibre.com>
In-Reply-To: <f6e7e4de-e1b7-f642-07cb-fa029ff2a883@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Aug 2019 00:40:14 +0200
Message-ID: <CAFBinCDDygiafTwLgqB9BimqrmwxL2=HFQD8cX8CQL23AFZNXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] soc: amlogic: Add support for Everything-Else
 power domains controller
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, ulf.hansson@linaro.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Neil,

On Mon, Aug 26, 2019 at 10:10 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 25/08/2019 23:10, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > thank you for this update
> > I haven't tried this on the 32-bit SoCs yet, but I am confident that I
> > can make it work by "just" adding the SoC specific bits!
> >
> > On Fri, Aug 23, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > [...]
> >> +/* AO Offsets */
> >> +
> >> +#define AO_RTI_GEN_PWR_SLEEP0          (0x3a << 2)
> >> +#define AO_RTI_GEN_PWR_ISO0            (0x3b << 2)
> >> +
> >> +/* HHI Offsets */
> >> +
> >> +#define HHI_MEM_PD_REG0                        (0x40 << 2)
> >> +#define HHI_VPU_MEM_PD_REG0            (0x41 << 2)
> >> +#define HHI_VPU_MEM_PD_REG1            (0x42 << 2)
> >> +#define HHI_VPU_MEM_PD_REG3            (0x43 << 2)
> >> +#define HHI_VPU_MEM_PD_REG4            (0x44 << 2)
> >> +#define HHI_AUDIO_MEM_PD_REG0          (0x45 << 2)
> >> +#define HHI_NANOQ_MEM_PD_REG0          (0x46 << 2)
> >> +#define HHI_NANOQ_MEM_PD_REG1          (0x47 << 2)
> >> +#define HHI_VPU_MEM_PD_REG2            (0x4d << 2)
> > should we switch to the actual register offsets like we did in the
> > clock drivers?
>
> I find it simpler to refer to the numbers in the documentation...
OK, I have no strong preference here
for the 32-bit SoCs I will need to use the offsets based on the
"amlogic,meson8b-pmu", "syscon" [0], so these will be magic anyways

[...]
> >> +#define VPU_HHI_MEMPD(__reg)                                   \
> >> +       { __reg, BIT(8) },                                      \
> >> +       { __reg, BIT(9) },                                      \
> >> +       { __reg, BIT(10) },                                     \
> >> +       { __reg, BIT(11) },                                     \
> >> +       { __reg, BIT(12) },                                     \
> >> +       { __reg, BIT(13) },                                     \
> >> +       { __reg, BIT(14) },                                     \
> >> +       { __reg, BIT(15) }
> > the Amlogic implementation from buildroot-openlinux-A113-201901 (the
> > latest one I have)
> > kernel/aml-4.9/drivers/amlogic/media/vout/hdmitx/hdmi_tx_20/hw/hdmi_tx_hw.c
> > uses:
> > hd_set_reg_bits(P_HHI_MEM_PD_REG0, 0, 8, 8)
> > that basically translates to: GENMASK(15, 8) (which means we could
> > drop this macro)
> >
> > the datasheet also states: 15~8 [...] HDMI memory PD (as a single
> > 8-bit wide register)
>
> Yep, but the actual code setting the VPU power domain is in u-boot :
>
> drivers/vpu/aml_vpu_power_init.c:
> 108         for (i = 8; i < 16; i++) {
> 109                 vpu_hiu_setb(HHI_MEM_PD_REG0, 0, i, 1);
> 110                 udelay(5);
> 111         }
>
> the linux code is like never used here, my preference goes to the u-boot code
> implementation.
I see, let's keep your implementation then

> >
> > [...]
> >> +static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
> >> +       [PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &g12a_pwrc_vpu, g12a_pwrc_mem_vpu,
> >> +                                    pwrc_ee_get_power, 11, 2),
> >> +       [PWRC_G12A_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
> >> +};
> >> +
> >> +static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
> >> +       [PWRC_SM1_VPU_ID]  = VPU_PD("VPU", &sm1_pwrc_vpu, sm1_pwrc_mem_vpu,
> >> +                                   pwrc_ee_get_power, 11, 2),
> >> +       [PWRC_SM1_NNA_ID]  = TOP_PD("NNA", &sm1_pwrc_nna, sm1_pwrc_mem_nna,
> >> +                                   pwrc_ee_get_power),
> >> +       [PWRC_SM1_USB_ID]  = TOP_PD("USB", &sm1_pwrc_usb, sm1_pwrc_mem_usb,
> >> +                                   pwrc_ee_get_power),
> >> +       [PWRC_SM1_PCIE_ID] = TOP_PD("PCI", &sm1_pwrc_pci, sm1_pwrc_mem_pcie,
> >> +                                   pwrc_ee_get_power),
> >> +       [PWRC_SM1_GE2D_ID] = TOP_PD("GE2D", &sm1_pwrc_ge2d, sm1_pwrc_mem_ge2d,
> >> +                                   pwrc_ee_get_power),
> >> +       [PWRC_SM1_AUDIO_ID] = MEM_PD("AUDIO", sm1_pwrc_mem_audio),
> >> +       [PWRC_SM1_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
> >> +};
> > my impression: I find this hard to read as it merges the TOP and
> > Memory PD domains from above, adding some seemingly random "11, 2" for
> > the VPU PD as well as pwrc_ee_get_power for some of the power domains
> > personally I like the way we describe clk_regmap because it's easy to
> > read (even though it adds a bit of boilerplate). I'm not sure if we
> > can make it work here, but this (not compile tested) is what I have in
> > mind (I chose two random power domains):
> >   [PWRC_SM1_VPU_ID]  = {
> >     .name = "VPU",
> >     .top_pd = SM1_EE_PD(8),
> >     .mem_pds = {
> >         VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
> >         VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
> >         VPU_MEMPD(HHI_VPU_MEM_PD_REG2),
> >         VPU_MEMPD(HHI_VPU_MEM_PD_REG3),
> >         { HHI_VPU_MEM_PD_REG4, GENMASK(1, 0) },
> >         { HHI_VPU_MEM_PD_REG4, GENMASK(3, 2) },
> >         { HHI_VPU_MEM_PD_REG4, GENMASK(5, 4) },
> >         { HHI_VPU_MEM_PD_REG4, GENMASK(7, 6) },
> >         { HHI_MEM_PD_REG0, GENMASK(15, 8) },
> >     },
> >     .num_mem_pds = 9,
> >     .reset_names_count = 11,
> >     .clk_names_count = 2,
> >   },
> >   [PWRC_SM1_ETH_ID] = {
> >     .name = "ETH",
> >     .mem_pds = { HHI_MEM_PD_REG0, GENMASK(3, 2) },
> >     .num_mem_pds = 1,
> >   },
> > ...
> >
> > I'd like to get Kevin's feedback on this
> > what you have right now is probably good enough for the initial
> > version of this driver. I'm bringing this discussion up because we
> > will add support for more SoCs to this driver (we migrate GX over to
> > it and I want to add 32-bit SoC support, which probably means at least
> > Meson8 - assuming they kept the power domains identical between
> > Meson8/8b/8m2).
>
> I find it more compact, but nothing is set in stone, you can refactor this as
> will when adding meson8 support, no problems here.
OK. if Kevin (or someone else) has feedback on this then I don't have
to waste time if it turns out that it's not a great idea ;)

> >
> > [...]
> >> +struct meson_ee_pwrc_domain {
> >> +       struct generic_pm_domain base;
> >> +       bool enabled;
> >> +       struct meson_ee_pwrc *pwrc;
> >> +       struct meson_ee_pwrc_domain_desc desc;
> >> +       struct clk_bulk_data *clks;
> >> +       int num_clks;
> >> +       struct reset_control *rstc;
> >> +       int num_rstc;
> >> +};
> >> +
> >> +struct meson_ee_pwrc {
> >> +       struct regmap *regmap_ao;
> >> +       struct regmap *regmap_hhi;
> >> +       struct meson_ee_pwrc_domain *domains;
> >> +       struct genpd_onecell_data xlate;
> >> +};
> > (my impressions on this: I was surprised to find more structs down
> > here, I expected them to be together with the other structs further
> > up)
>
> These are the "live" structures, opposed to the static structures defining the
> data and these are allocated and filled a probe time.
I see, thanks for the explanation

> I dislike changing static global data at runtime, this is why I clearly separated both.
I didn't mean to make them static - the thing that caught my eye was
that some of the structs are defined at the top of the driver while
these two are define much further down
I am used to having all struct definitions in one place

> >
> >> +static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain)
> >> +{
> >> +       u32 reg;
> >> +
> >> +       regmap_read(pwrc_domain->pwrc->regmap_ao,
> >> +                   pwrc_domain->desc.top_pd->sleep_reg, &reg);
> >> +
> >> +       return (reg & pwrc_domain->desc.top_pd->sleep_mask);
> > should this also check for top_pd->iso_* as well as mem_pd->*?
> > if the top_pd part was optional we could even use the get_power
> > callback for *all* power domains in this driver (right now audio and
> > Ethernet don't have any get_power callback)
>
> We could, but how should we handle if one unexpected bit is set ? No idea...
hmm, I see
if we need it for other power domains then we can still implement it,
so it's good for now

[...]
> > bonus question: what about the video decoder power domains?
> > here is an example from vdec_1_start
> > (drivers/staging/media/meson/vdec/vdec_1.c):
> >   /* Enable power for VDEC_1 */
> >   regmap_update_bits(core->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
> >                                    GEN_PWR_VDEC_1, 0);
> >   usleep_range(10, 20);
> >   [...]
> >   /* enable VDEC Memories */
> >   amvdec_write_dos(core, DOS_MEM_PD_VDEC, 0);
> >   /* Remove VDEC1 Isolation */
> >   regmap_write(core->regmap_ao, AO_RTI_GEN_PWR_ISO0, 0);
> >
> > (my point here is that it mixes video decoder "DOS" registers with
> > AO_RTI_GEN_PWR registers)
> > do we also want to add support for these "DOS" power domains to the
> > meson-ee-pwrc driver?
> > what about the AO_RTI_GEN_PWR part then - should we keep management
> > for the video decoder power domain bits in AO_RTI_GEN_PWR as part of
> > the video decoder driver?
>
> I left the decoders power domains aside so we can discuss it later on,
> we should expose multiple power domains, but the driver would need to
> be changed to support multiple power domains. But will loose the ability
> to enable/disable each domain at will unless it created a sub-device for
> each decoder and attaches the domain to to each device and use runtime pm.
>
> It's simpler to discuss it later on !
OK - does this mean you and/or Maxime have "discuss decoder power
domains" on your (long) TODO-list or do you want me to open this
discussion after this driver is merged?


Martin


[0] https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/amlogic/pmu.txt
