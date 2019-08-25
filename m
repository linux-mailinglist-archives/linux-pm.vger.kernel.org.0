Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF8B9C633
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2019 23:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfHYVK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Aug 2019 17:10:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37252 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfHYVK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Aug 2019 17:10:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id f17so13424319otq.4;
        Sun, 25 Aug 2019 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9gjegwnI6OBBah3d2fTdkIhLyzSL2rtGnti5w4uvpo=;
        b=QtRQGTtUggKslNSNfDajB0M1GmmhHEFREp9oRRy4RMHffFk+XieXygxVW99UIyF4aH
         0TawtEok8f9IiNmWoU0UU/FwV29q+ZgY5cCi9HTZz06xGz8Ca0oeHWMi0kMUr5B9Qyp8
         VyK+XkAAujnw2lgTFfMeqRz3bh79miW+yXna21ynB2jMXjci3ZmMEXdvi/hOrKThsY4i
         YJQC+0ObSHgREASlUScl50LtJEPsm1PP1heAe/grcVmyaPZko14jirabef3nC1S90DBN
         afl16oGOUZvNaVoi7i2t19eLjWSySULKeNhIpmhHingumGyBa0zsqu9yvuNGoFu4EnLU
         bP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9gjegwnI6OBBah3d2fTdkIhLyzSL2rtGnti5w4uvpo=;
        b=iTgt+kzdO+CUScNFJrfAYADJJgUkGHVNPy6G8exjB9/Wotkfi0pU/JbyAOC68xU9JP
         wbUNSzxN8mSAK1ovXViSNZnr+yQGwW3F3ZK9BjjzVNiqxUAXBy6SbrCth6JnBYZN+DeI
         vI/BH57kc+feK7A+AnsXwDwOfk3DAEy3AZMLj64cvcXKrvouMsIh8ysfOinoWOgQ8syv
         wkJn8vDFXeBD78fCthuwIMenQfFWGYlKFbyY7IxqglnJdoN9SHxXA0FttqwIPalxrX/0
         ATo5WxvtHvY+fY5jmH37R4Qwd4cel1Be1E1nsB9HsM9tNff+lfCQvHmzr+74s404E4t4
         Dpdg==
X-Gm-Message-State: APjAAAXsa2hhmYxd9r/eXblmgtj2CTIDOE5XQgL+KidwbhAud2fvg+gk
        5kVOdTV//+M6ToPf09gnTnImd4xIhMv1cOH91IE=
X-Google-Smtp-Source: APXvYqwTyTMd/9N2zEhcBHPdhl22US+MfcqV8H4IREoHvPCHyE6MzDXNq5wbch6OQvG0gSjRPgPiaN+TMlnSWjkQQNw=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr12211285otj.96.1566767425426;
 Sun, 25 Aug 2019 14:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190823090418.17148-1-narmstrong@baylibre.com> <20190823090418.17148-3-narmstrong@baylibre.com>
In-Reply-To: <20190823090418.17148-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Aug 2019 23:10:14 +0200
Message-ID: <CAFBinCBy-VxfSMPMR0cEDuNg8=UOUVvWfkDi2Tp=QhBZka93aQ@mail.gmail.com>
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

thank you for this update
I haven't tried this on the 32-bit SoCs yet, but I am confident that I
can make it work by "just" adding the SoC specific bits!

On Fri, Aug 23, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +/* AO Offsets */
> +
> +#define AO_RTI_GEN_PWR_SLEEP0          (0x3a << 2)
> +#define AO_RTI_GEN_PWR_ISO0            (0x3b << 2)
> +
> +/* HHI Offsets */
> +
> +#define HHI_MEM_PD_REG0                        (0x40 << 2)
> +#define HHI_VPU_MEM_PD_REG0            (0x41 << 2)
> +#define HHI_VPU_MEM_PD_REG1            (0x42 << 2)
> +#define HHI_VPU_MEM_PD_REG3            (0x43 << 2)
> +#define HHI_VPU_MEM_PD_REG4            (0x44 << 2)
> +#define HHI_AUDIO_MEM_PD_REG0          (0x45 << 2)
> +#define HHI_NANOQ_MEM_PD_REG0          (0x46 << 2)
> +#define HHI_NANOQ_MEM_PD_REG1          (0x47 << 2)
> +#define HHI_VPU_MEM_PD_REG2            (0x4d << 2)
should we switch to the actual register offsets like we did in the
clock drivers?

[...]
> +static struct meson_ee_pwrc_top_domain sm1_pwrc_vpu = SM1_EE_PD(8);
nit-pick: maybe name it sm1_pwrc_vpu_hdmi as the datasheet states that
it's for "VPU/HDMI"

[...]
> +#define VPU_HHI_MEMPD(__reg)                                   \
> +       { __reg, BIT(8) },                                      \
> +       { __reg, BIT(9) },                                      \
> +       { __reg, BIT(10) },                                     \
> +       { __reg, BIT(11) },                                     \
> +       { __reg, BIT(12) },                                     \
> +       { __reg, BIT(13) },                                     \
> +       { __reg, BIT(14) },                                     \
> +       { __reg, BIT(15) }
the Amlogic implementation from buildroot-openlinux-A113-201901 (the
latest one I have)
kernel/aml-4.9/drivers/amlogic/media/vout/hdmitx/hdmi_tx_20/hw/hdmi_tx_hw.c
uses:
hd_set_reg_bits(P_HHI_MEM_PD_REG0, 0, 8, 8)
that basically translates to: GENMASK(15, 8) (which means we could
drop this macro)

the datasheet also states: 15~8 [...] HDMI memory PD (as a single
8-bit wide register)

[...]
> +static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
> +       [PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &g12a_pwrc_vpu, g12a_pwrc_mem_vpu,
> +                                    pwrc_ee_get_power, 11, 2),
> +       [PWRC_G12A_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
> +};
> +
> +static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
> +       [PWRC_SM1_VPU_ID]  = VPU_PD("VPU", &sm1_pwrc_vpu, sm1_pwrc_mem_vpu,
> +                                   pwrc_ee_get_power, 11, 2),
> +       [PWRC_SM1_NNA_ID]  = TOP_PD("NNA", &sm1_pwrc_nna, sm1_pwrc_mem_nna,
> +                                   pwrc_ee_get_power),
> +       [PWRC_SM1_USB_ID]  = TOP_PD("USB", &sm1_pwrc_usb, sm1_pwrc_mem_usb,
> +                                   pwrc_ee_get_power),
> +       [PWRC_SM1_PCIE_ID] = TOP_PD("PCI", &sm1_pwrc_pci, sm1_pwrc_mem_pcie,
> +                                   pwrc_ee_get_power),
> +       [PWRC_SM1_GE2D_ID] = TOP_PD("GE2D", &sm1_pwrc_ge2d, sm1_pwrc_mem_ge2d,
> +                                   pwrc_ee_get_power),
> +       [PWRC_SM1_AUDIO_ID] = MEM_PD("AUDIO", sm1_pwrc_mem_audio),
> +       [PWRC_SM1_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
> +};
my impression: I find this hard to read as it merges the TOP and
Memory PD domains from above, adding some seemingly random "11, 2" for
the VPU PD as well as pwrc_ee_get_power for some of the power domains
personally I like the way we describe clk_regmap because it's easy to
read (even though it adds a bit of boilerplate). I'm not sure if we
can make it work here, but this (not compile tested) is what I have in
mind (I chose two random power domains):
  [PWRC_SM1_VPU_ID]  = {
    .name = "VPU",
    .top_pd = SM1_EE_PD(8),
    .mem_pds = {
        VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
        VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
        VPU_MEMPD(HHI_VPU_MEM_PD_REG2),
        VPU_MEMPD(HHI_VPU_MEM_PD_REG3),
        { HHI_VPU_MEM_PD_REG4, GENMASK(1, 0) },
        { HHI_VPU_MEM_PD_REG4, GENMASK(3, 2) },
        { HHI_VPU_MEM_PD_REG4, GENMASK(5, 4) },
        { HHI_VPU_MEM_PD_REG4, GENMASK(7, 6) },
        { HHI_MEM_PD_REG0, GENMASK(15, 8) },
    },
    .num_mem_pds = 9,
    .reset_names_count = 11,
    .clk_names_count = 2,
  },
  [PWRC_SM1_ETH_ID] = {
    .name = "ETH",
    .mem_pds = { HHI_MEM_PD_REG0, GENMASK(3, 2) },
    .num_mem_pds = 1,
  },
...

I'd like to get Kevin's feedback on this
what you have right now is probably good enough for the initial
version of this driver. I'm bringing this discussion up because we
will add support for more SoCs to this driver (we migrate GX over to
it and I want to add 32-bit SoC support, which probably means at least
Meson8 - assuming they kept the power domains identical between
Meson8/8b/8m2).

[...]
> +struct meson_ee_pwrc_domain {
> +       struct generic_pm_domain base;
> +       bool enabled;
> +       struct meson_ee_pwrc *pwrc;
> +       struct meson_ee_pwrc_domain_desc desc;
> +       struct clk_bulk_data *clks;
> +       int num_clks;
> +       struct reset_control *rstc;
> +       int num_rstc;
> +};
> +
> +struct meson_ee_pwrc {
> +       struct regmap *regmap_ao;
> +       struct regmap *regmap_hhi;
> +       struct meson_ee_pwrc_domain *domains;
> +       struct genpd_onecell_data xlate;
> +};
(my impressions on this: I was surprised to find more structs down
here, I expected them to be together with the other structs further
up)

> +static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain)
> +{
> +       u32 reg;
> +
> +       regmap_read(pwrc_domain->pwrc->regmap_ao,
> +                   pwrc_domain->desc.top_pd->sleep_reg, &reg);
> +
> +       return (reg & pwrc_domain->desc.top_pd->sleep_mask);
should this also check for top_pd->iso_* as well as mem_pd->*?
if the top_pd part was optional we could even use the get_power
callback for *all* power domains in this driver (right now audio and
Ethernet don't have any get_power callback)

> +}
> +
> +static int meson_ee_pwrc_off(struct generic_pm_domain *domain)
> +{
> +       struct meson_ee_pwrc_domain *pwrc_domain =
> +               container_of(domain, struct meson_ee_pwrc_domain, base);
> +       int i;
> +
> +       if (pwrc_domain->desc.top_pd)
> +               regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
> +                                  pwrc_domain->desc.top_pd->sleep_reg,
> +                                  pwrc_domain->desc.top_pd->sleep_mask,
> +                                  pwrc_domain->desc.top_pd->sleep_mask);
> +       udelay(20);
all four udelay(20) occurrences should probably be usleep_range(20,
100); (or some other max value), see [0]

[...]
> +       /*
> +         * TOFIX: This is a special case for the VPU power domain, which can
> +        * be enabled previously by the bootloader. In this case the VPU
nit-pick: the indentation seems to be off here

[...]
> +static int meson_ee_pwrc_probe(struct platform_device *pdev)
> +{
> +       const struct meson_ee_pwrc_domain_data *match;
> +       struct regmap *regmap_ao, *regmap_hhi;
> +       struct meson_ee_pwrc *pwrc;
> +       int i, ret;
> +
> +       match = of_device_get_match_data(&pdev->dev);
> +       if (!match) {
> +               dev_err(&pdev->dev, "failed to get match data\n");
> +               return -ENODEV;
> +       }
> +
> +       pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> +       if (!pwrc)
> +               return -ENOMEM;
> +
> +       pwrc->xlate.domains = devm_kcalloc(&pdev->dev, match->count,
> +                                          sizeof(*pwrc->xlate.domains),
> +                                          GFP_KERNEL);
> +       if (!pwrc->xlate.domains)
> +               return -ENOMEM;
> +
> +       pwrc->domains = devm_kcalloc(&pdev->dev, match->count,
> +                                    sizeof(*pwrc->domains), GFP_KERNEL);
> +       if (!pwrc->domains)
> +               return -ENOMEM;
> +
> +       pwrc->xlate.num_domains = match->count;
> +
> +       regmap_hhi = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
> +       if (IS_ERR(regmap_hhi)) {
> +               dev_err(&pdev->dev, "failed to get HHI regmap\n");
> +               return PTR_ERR(regmap_hhi);
> +       }
> +
> +       regmap_ao = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                                                   "amlogic,ao-sysctrl");
> +       if (IS_ERR(regmap_ao)) {
> +               dev_err(&pdev->dev, "failed to get AO regmap\n");
> +               return PTR_ERR(regmap_ao);
> +       }
> +
> +       pwrc->regmap_ao = regmap_ao;
> +       pwrc->regmap_hhi = regmap_hhi;
> +
> +       platform_set_drvdata(pdev, pwrc);
> +
> +       for (i = 0 ; i < match->count ; ++i) {
> +               struct meson_ee_pwrc_domain *dom = &pwrc->domains[i];
> +
> +               memcpy(&dom->desc, &match->domains[i], sizeof(dom->desc));
> +
> +               ret = meson_ee_pwrc_init_domain(pdev, pwrc, dom);
> +               if (ret)
> +                       return ret;
> +
> +               pwrc->xlate.domains[i] = &dom->base;
> +       }
> +
> +       of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
return of_genpd_add_provider_onecell(...) to propagate errors (if any)

bonus question: what about the video decoder power domains?
here is an example from vdec_1_start
(drivers/staging/media/meson/vdec/vdec_1.c):
  /* Enable power for VDEC_1 */
  regmap_update_bits(core->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
                                   GEN_PWR_VDEC_1, 0);
  usleep_range(10, 20);
  [...]
  /* enable VDEC Memories */
  amvdec_write_dos(core, DOS_MEM_PD_VDEC, 0);
  /* Remove VDEC1 Isolation */
  regmap_write(core->regmap_ao, AO_RTI_GEN_PWR_ISO0, 0);

(my point here is that it mixes video decoder "DOS" registers with
AO_RTI_GEN_PWR registers)
do we also want to add support for these "DOS" power domains to the
meson-ee-pwrc driver?
what about the AO_RTI_GEN_PWR part then - should we keep management
for the video decoder power domain bits in AO_RTI_GEN_PWR as part of
the video decoder driver?


Martin


[0] https://www.kernel.org/doc/Documentation/timers/timers-howto.rst
