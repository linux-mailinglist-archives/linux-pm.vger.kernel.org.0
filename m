Return-Path: <linux-pm+bounces-35710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF1BB838C
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 23:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778F619C59F4
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 21:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E14267B12;
	Fri,  3 Oct 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0E8DIlt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7740265CB3
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527690; cv=none; b=r9ONckJxmvGecBbHgB6bA04Wuty5wKrq5ezRJtfmiwFWmnIZWQ9Q4Pm5Tt/k8XiYEfxkHN0BryWB0XUiDW8xRFXM2O9JFhVAZ6H7ndum/MD0zAArUpOZmpVJDUdHWcdy4Yac+Dowm7eAz0dKQAmcBjhtN0Zg/4dNVMMLCwODhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527690; c=relaxed/simple;
	bh=4PujLlPsvKlOpMJYFavOYjiTXGw+gkZUWLjSvWm1spw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9KL82GClE/1Af9hfI03IMbB/Kr+ThMqhCVehUYtpNzhTOsgFF0AVMfPKTeV+F8xfvyB33y1fTfa5qPXA/OyXA2WuKf6Qn34M6P2Ax1xI3d+TSGo43xWmPkak+tFotmv7Z/VoCW4Y0Or3cjwJ0iDKXJgZhKyuYfAviZWIxkeZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0E8DIlt; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6360397e8c7so3115215d50.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759527688; x=1760132488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UUYFCqYZ++M1SNLRvfnBEMc8eDA11OJCrWneq89QMU=;
        b=T0E8DIltCtk7xgqEByDPhaks0rkTN2iyaTjb2liVTPyD1olnewXnzRo1WyNC6O+r+e
         3Lmf3apeBBLZ6X7MiTDf8HpufXMDKm/mpN4eVgIuqfLxaGXIQmRKks3O3f+iuc4djcAK
         zU0u/Nyd9Co77JL2BDsecTaBYTbSHMoU8MkMbwLkWYgVfOe99L5oz9LAKwZzxKg5IxDr
         TbRQXew+AgXZl0WEGW2Wjc/IKupiwKS1Ii2xLOOouuH8NeGSWh7AuyEy7HQno5I5nxfp
         QXBtEdRC20M46is1TlnfZEWM2ncfp/wjnQx1NEueL8F6VBUoOae++rBfqluMm/9Ri5AK
         vgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527688; x=1760132488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UUYFCqYZ++M1SNLRvfnBEMc8eDA11OJCrWneq89QMU=;
        b=eE6Wt3pDWLBQ8VE/iXvKGpQkbyd5KrO9gx7WQUG5Ujg6Xer1naR+AsypCf90896hqk
         5oguWH0KRC4yuFjcmFM6dj+cNHpl57LLGcM8bHgE3xSLk80k5hU5f3k5yazeVqVnV6+A
         muZwo6gRXArPajJHKgTba9gFxwqEphYfmzosxcovusEggrXwxsCKh4CytxjONo5sDlw+
         KdXanYH+Y8VEjdvqaM6uEejuw/hlakxHRjG9D6Kbnzl+jxeBRj4T4BeFYglGs269PEe+
         dI08NtjvWm3S63lbepHNjJhJlfZ6LjqRyUVxtvvYdxTI3b8kUZUWLSJetqtGvHVBsGW5
         YXzA==
X-Forwarded-Encrypted: i=1; AJvYcCUgl5W3e3hqUKJfDv5o773DpZ7ohgkLg5NrwWw7zdxYHoXygJqFxvyqEZ0DIqqROD89yobLtPmHIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRBfarnabc10Wm3jC2Brr+P1yRK6tI561ySqmx2QSTXo0lHKA
	ija/1N2FdQTb2Pd+eHtB6MFHK1alOtrz/iFHAT/+Semy79srukmP7/9Q/vrIkl7R1UF4C2KXjZo
	wcKbQkrDBbfHUd43eYvjFkMtOo0J0/4I=
X-Gm-Gg: ASbGnct4SaaamEYLhXnbHXX7SYF17nkWKCctLCg7+S4d1OvcFIlop8qpy3uR6j8EO98
	Ih94g1L3XRj3TbHSNtntvZujOiTa6VyvhAT4nV890RpIqsdMK9k3+rAKcvWnTYT7idcbgOGgJ0y
	SQAUrdPxSocidASP//JW2OHR6fb32Em+GRCAIL5qOksrqNKfGYUzgJcPjdOs50f5Sx8YjG3oq/z
	+olEopvUIieDeF2NtC89SJDfkacl9T9VWNG9/wlfuYkzfxfZv+lExZ4WMz2aIobNRYkPYXny6St
	cU1QAL8AohZ2UGw15+nNTJbIOAiDgVM47sQpW23EQ3Q=
X-Google-Smtp-Source: AGHT+IFsEBPVzXvwHuM4QLRckQ1pwH09RM2qcZ+I8xh8RlXcjUu54Stm4Ca7trrl5nG3IQUJmBvrF+RgEH/+4vhA4Po=
X-Received: by 2002:a53:ca11:0:b0:62c:70de:7cba with SMTP id
 956f58d0204a3-63b9a0a7345mr3380422d50.22.1759527687648; Fri, 03 Oct 2025
 14:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com> <20251003-mt8196-gpufreq-v6-7-76498ad61d9e@collabora.com>
In-Reply-To: <20251003-mt8196-gpufreq-v6-7-76498ad61d9e@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 14:41:16 -0700
X-Gm-Features: AS18NWBtZLeN2JMlM8B0j97iXzqvvw6RLai7sdHK1_VKcIavLpBYUP0KgralcMQ
Message-ID: <CAPaKu7QWBShwr+YhFi+nUFo0kJ06k4PK3zggcCefWGjqUmTx5w@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:16=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> integration silicon is required to power on the GPU.
>
> This glue silicon is in the form of an embedded microcontroller running
> special-purpose firmware, which autonomously adjusts clocks and
> regulators.
>
> Implement a driver, modelled as a pmdomain driver with a
> set_performance_state operation, to support these SoCs.
I like this model a lot. Thanks!

panthor might potentially need to interact with this driver beyond
what pmdomain provides. I am thinking about querying
GF_REG_SHADER_PRESENT. Not sure if we've heard back from the vendor.
Have you considered moving this to drivers/soc/mediatek such that we
can provide include/linux/mtk-mfg.h to panthor?

>
> The driver also exposes the actual achieved clock rate, as read back
> from the MCU, as common clock framework clocks, by acting as a clock
> provider as well.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/pmdomain/mediatek/Kconfig            |   16 +
>  drivers/pmdomain/mediatek/Makefile           |    1 +
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 1027 ++++++++++++++++++++=
++++++
>  3 files changed, 1044 insertions(+)
[...]
> +static int mtk_mfg_init_shared_mem(struct mtk_mfg *mfg)
> +{
> +       struct device *dev =3D &mfg->pdev->dev;
> +       struct mtk_mfg_ipi_msg msg =3D {};
> +       int ret;
> +
> +       dev_dbg(dev, "clearing GPUEB shared memory, 0x%X bytes\n", mfg->s=
hared_mem_size);
> +       memset_io(mfg->shared_mem, 0, mfg->shared_mem_size);
> +
> +       msg.cmd =3D CMD_INIT_SHARED_MEM;
> +       msg.u.shared_mem.base =3D mfg->shared_mem_phys;
> +       msg.u.shared_mem.size =3D mfg->shared_mem_size;
> +
> +       ret =3D mtk_mfg_send_ipi(mfg, &msg);
> +       if (ret)
> +               return ret;
> +
> +       if (readl(mfg->shared_mem) !=3D GPUEB_MEM_MAGIC) {
Add the offset GF_REG_MAGIC, even though it is 0.

> +               dev_err(dev, "EB did not initialise shared memory correct=
ly\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
[...]
> +static int mtk_mfg_mt8196_init(struct mtk_mfg *mfg)
> +{
> +       void __iomem *e2_base;
> +
> +       e2_base =3D devm_platform_ioremap_resource_byname(mfg->pdev, "hw-=
revision");
> +       if (IS_ERR(e2_base))
> +               return dev_err_probe(&mfg->pdev->dev, PTR_ERR(e2_base),
> +                                    "Couldn't get hw-revision register\n=
");
> +
> +       if (readl(e2_base) =3D=3D MFG_MT8196_E2_ID)
> +               mfg->ghpm_en_reg =3D RPC_DUMMY_REG_2;
> +       else
> +               mfg->ghpm_en_reg =3D RPC_GHPM_CFG0_CON;
> +
> +       return 0;
> +};
Extraneous semicolon.

> +static int mtk_mfg_init_mbox(struct mtk_mfg *mfg)
> +{
> +       struct device *dev =3D &mfg->pdev->dev;
> +       struct mtk_mfg_mbox *gf;
> +       struct mtk_mfg_mbox *slp;
> +
> +       gf =3D devm_kzalloc(dev, sizeof(*gf), GFP_KERNEL);
> +       if (!gf)
> +               return -ENOMEM;
> +
> +       gf->rx_data =3D devm_kzalloc(dev, GPUEB_MBOX_MAX_RX_SIZE, GFP_KER=
NEL);
It looks like gfx->rx_data can simply be "struct mtk_mfg_ipi_msg rx_data;".

> +       if (!gf->rx_data)
> +               return -ENOMEM;
> +
> +       gf->mfg =3D mfg;
> +       init_completion(&gf->rx_done);
> +       gf->cl.dev =3D dev;
> +       gf->cl.rx_callback =3D mtk_mfg_mbox_rx_callback;
> +       gf->cl.tx_tout =3D GPUEB_TIMEOUT_US / USEC_PER_MSEC;
> +       gf->ch =3D mbox_request_channel_byname(&gf->cl, "gpufreq");
> +       if (IS_ERR(gf->ch))
> +               return PTR_ERR(gf->ch);
> +
> +       mfg->gf_mbox =3D gf;
> +
> +       slp =3D devm_kzalloc(dev, sizeof(*slp), GFP_KERNEL);
> +       if (!slp)
> +               return -ENOMEM;
> +
> +       slp->mfg =3D mfg;
> +       init_completion(&slp->rx_done);
> +       slp->cl.dev =3D dev;
> +       slp->cl.tx_tout =3D GPUEB_TIMEOUT_US / USEC_PER_MSEC;
> +       slp->cl.tx_block =3D true;
> +       slp->ch =3D mbox_request_channel_byname(&slp->cl, "sleep");
> +       if (IS_ERR(slp->ch))
> +               return PTR_ERR(slp->ch);
Free gf->ch.
> +
> +       mfg->slp_mbox =3D slp;
> +
> +       return 0;
> +}
> +
> +static int mtk_mfg_init_clk_provider(struct mtk_mfg *mfg)
> +{
> +       struct device *dev =3D &mfg->pdev->dev;
> +       struct clk_hw_onecell_data *clk_data;
> +       int ret;
> +
> +       clk_data =3D devm_kzalloc(dev, struct_size(clk_data, hws, 2), GFP=
_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       clk_data->num =3D 2;
> +
> +       mfg->clk_core_hw.init =3D &mtk_mfg_clk_gpu_init;
> +       mfg->clk_stack_hw.init =3D &mtk_mfg_clk_stack_init;
> +
> +       ret =3D devm_clk_hw_register(dev, &mfg->clk_core_hw);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't register GPU cor=
e clock\n");
> +
> +       ret =3D devm_clk_hw_register(dev, &mfg->clk_stack_hw);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't register GPU sta=
ck clock\n");
> +
> +       clk_data->hws[0] =3D &mfg->clk_core_hw;
> +       clk_data->hws[1] =3D &mfg->clk_stack_hw;
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, c=
lk_data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't register clock p=
rovider\n");
> +
> +       return 0;
> +}
> +
> +static int mtk_mfg_probe(struct platform_device *pdev)
> +{
> +       struct device_node *shmem __free(device_node);
> +       struct mtk_mfg *mfg;
> +       struct device *dev =3D &pdev->dev;
> +       const struct mtk_mfg_variant *data =3D of_device_get_match_data(d=
ev);
> +       struct resource res;
> +       int ret, i;
> +
> +       mfg =3D devm_kzalloc(dev, sizeof(*mfg), GFP_KERNEL);
> +       if (!mfg)
> +               return -ENOMEM;
> +
> +       mfg->pdev =3D pdev;
> +       mfg->variant =3D data;
> +
> +       dev_set_drvdata(dev, mfg);
> +
> +       mfg->gpr =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(mfg->gpr))
> +               return dev_err_probe(dev, PTR_ERR(mfg->gpr),
> +                                    "Couldn't retrieve GPR MMIO register=
s\n");
> +
> +       mfg->rpc =3D devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(mfg->rpc))
> +               return dev_err_probe(dev, PTR_ERR(mfg->rpc),
> +                                    "Couldn't retrieve RPC MMIO register=
s\n");
> +
> +       mfg->clk_eb =3D devm_clk_get(dev, "eb");
> +       if (IS_ERR(mfg->clk_eb))
> +               return dev_err_probe(dev, PTR_ERR(mfg->clk_eb),
> +                                    "Couldn't get 'eb' clock\n");
> +
> +       mfg->gpu_clks =3D devm_kcalloc(dev, data->num_clks, sizeof(*mfg->=
gpu_clks),
> +                                    GFP_KERNEL);
> +       if (!mfg->gpu_clks)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < data->num_clks; i++)
> +               mfg->gpu_clks[i].id =3D data->clk_names[i];
> +
> +       ret =3D devm_clk_bulk_get(dev, data->num_clks, mfg->gpu_clks);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't get GPU clocks\n=
");
> +
> +       mfg->gpu_regs =3D devm_kcalloc(dev, data->num_regulators,
> +                                    sizeof(*mfg->gpu_regs), GFP_KERNEL);
> +       if (!mfg->gpu_regs)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < data->num_regulators; i++)
> +               mfg->gpu_regs[i].supply =3D data->regulator_names[i];
> +
> +       ret =3D devm_regulator_bulk_get(dev, data->num_regulators, mfg->g=
pu_regs);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't get GPU regulato=
rs\n");
> +
> +       ret =3D of_reserved_mem_region_to_resource(dev->of_node, 0, &res)=
;
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't get GPUEB shared=
 memory\n");
> +
> +       mfg->shared_mem =3D devm_ioremap(dev, res.start, resource_size(&r=
es));
> +       if (!mfg->shared_mem)
> +               return dev_err_probe(dev, -ENOMEM, "Can't ioremap GPUEB s=
hared memory\n");
> +       mfg->shared_mem_size =3D resource_size(&res);
> +       mfg->shared_mem_phys =3D res.start;
> +
> +       if (data->init) {
> +               ret =3D data->init(mfg);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "Variant init fail=
ed\n");
> +       }
> +
> +       mfg->pd.name =3D dev_name(dev);
> +       mfg->pd.attach_dev =3D mtk_mfg_attach_dev;
> +       mfg->pd.detach_dev =3D mtk_mfg_detach_dev;
> +       mfg->pd.power_off =3D mtk_mfg_power_off;
> +       mfg->pd.power_on =3D mtk_mfg_power_on;
> +       mfg->pd.set_performance_state =3D mtk_mfg_set_performance;
> +       mfg->pd.flags =3D GENPD_FLAG_OPP_TABLE_FW;
> +
> +       ret =3D pm_genpd_init(&mfg->pd, NULL, false);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to initialise powe=
r domain\n");
We need to clean up mgf->md on errors from this point on. Maybe we can
move this to a later point?

> +
> +       ret =3D mtk_mfg_init_mbox(mfg);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't initialise mailb=
ox\n");
We need to free the mboxes from this point on.

> +       ret =3D mtk_mfg_power_on(&mfg->pd);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to power on MFG\n"=
);
> +
> +       ret =3D mtk_mfg_init_shared_mem(mfg);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "Couldn't initialize EB shared me=
mory\n");
> +               goto out;
> +       }
> +
> +       ret =3D mtk_mfg_read_opp_tables(mfg);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "Error reading OPP tables from EB=
\n");
> +               goto out;
> +       }
> +
> +       ret =3D mtk_mfg_init_clk_provider(mfg);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D of_genpd_add_provider_simple(dev->of_node, &mfg->pd);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "Failed to add pmdomain provider\=
n");
> +               goto out;
> +       }
> +
> +       return 0;
> +
> +out:
> +       mtk_mfg_power_off(&mfg->pd);
> +       return ret;
> +}

