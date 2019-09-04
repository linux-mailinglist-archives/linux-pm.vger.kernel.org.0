Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D909A7ACB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfIDFj5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 01:39:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33327 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfIDFj4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 01:39:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so7439673pfl.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Sep 2019 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WkREPJ3HgKDy9/UVLFW3f0U4CYS+UhZPSQIMAfWKhIY=;
        b=sYC0uh0aEoUkVAV6xTGS309btMYILnOgcB0wzpeDPFnVCP/9XydgqYFqPN3NvAYsXW
         LVdDfFcDd0oJ7SvAPwoxgdKBGiaizUmq6x9o1mtShZfRN/lNP8+R7pFaljQ9c+PFQJts
         Ue4O5yslEp+rtTHiIy7H+JOPkl6ZCkIlxgMQnlpdHQdHterkRdKTzcMoNMCq/W5/lyMG
         GOovF421xoCHdCPeco80j3ltXAeYzOxdu/xiZg5BXJHp2lrDjPpfRdXaVruczjZd0Lbq
         ANPcw4YmVLMs3PYjVcWdwM2ha/24/HdC3uwyiLGtJUEsyduRMep9tn9Vho9au0FdqqZ5
         +TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WkREPJ3HgKDy9/UVLFW3f0U4CYS+UhZPSQIMAfWKhIY=;
        b=Z9jvOL76fT6NnwEUWX/TWvmYg7NTrWHK8G0oBsq3kcNHI1RSygEfhFYej3IChz3iqD
         y9QxhTb2rP/WR0/b0T97DlGk1f8/8sslNULGDGyPY/6PnWDaKOd1NYQWCNbPvBFSAEuh
         ZI5BJoVcXHodZx+d2EEHDlfV9LA2RQ/Q0IHbc2oUSYlaCrGu/VPU36dklUd/fg+6JWDY
         QeasAMQQDll6cFchkpnTn18Q1PjTpZ7NDXuuYg7QVYgxGQYsDj2Yk9tmFafS7a1LgrHi
         /NJXn/IgiT+qgX13NOLtZaCbnoDAq6wx3pM65+26+xUIzXsyQBFLcDXzx1PmO2mGml43
         nEzQ==
X-Gm-Message-State: APjAAAVYdyU/wW/7HtNM50cLZPQenpmZ7Zg7ypV2JA4G7O8Ur5kH2cCo
        xpy4PwC/cS0FD3Ne2u2IfY4HeQ==
X-Google-Smtp-Source: APXvYqyF7SiAf3LvYL99tGXIAEWIuZ0WQw79NvdT+dlNCZuAxu15L74twezCrWbZgnJ12xSzi6Is1Q==
X-Received: by 2002:a62:cdca:: with SMTP id o193mr25837165pfg.204.1567575595638;
        Tue, 03 Sep 2019 22:39:55 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 185sm33177672pff.54.2019.09.03.22.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 22:39:54 -0700 (PDT)
Date:   Tue, 3 Sep 2019 22:39:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] interconnect: qcom: add msm8974 driver
Message-ID: <20190904053952.GF3081@tuxbook-pro>
References: <20190902211925.27169-1-masneyb@onstation.org>
 <20190902211925.27169-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902211925.27169-3-masneyb@onstation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 02 Sep 14:19 PDT 2019, Brian Masney wrote:

> Add driver for the Qualcomm MSM8974 interconnect providers that support
> setting system bandwidth requirements between various network-on-chip
> fabrics.
> 
> I marked this as a PATCH RFC since I'm not able to write to all of the
> master IDs with qcom_icc_rpm_smd_send(). I included tables below that
> shows which of the 20 master IDs that I'm able to activate with
> qcom_icc_rpm_smd_send() [1] and the remaining 37 where
> qcom_icc_rpm_smd_send() fails with -ENXIO [2].
> 
> The device tree snippets that I'm using is in patch 1 of this series,
> however the relevant interconnect properties for the mdp5 are:
> 
>     interconnects = <&mmssnoc MNOC_MAS_GRAPHICS_3D &bimc BIMC_SLV_EBI_CH0>,
>                     <&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;
>     interconnect-names = "mdp0-mem", "mdp1-mem";
> 
> The two interconnects have the following paths:
> 
> - mdp0-mem
>   - mas_graphics_3d
>   - mnoc_to_bimc
>   - bimc_to_mnoc
>   - slv_ebi_ch0
> 
> - mdp1-mem
>   - mas_v_ocmem_gfx3d
>   - ocmem_vnoc_to_onoc
>   - ocmem_noc_to_ocmem_vnoc
>   - slv_ocmem
> 
> ocmem_noc_to_ocmem_vnoc is the only one that is successfully activated
> and the remaining fail in these two paths.
> 
> With this interconnect driver, I am able to remove a clock hack that I
> had in place that set the speed of MDSS_AXI_CLK high and I'm able to use
> kmscube. However, I do see a clock warning on system startup [3].
> 
> The display doesn't work for me with the downstream MSM sources so I may
> have to get that working to debug this some more unless anyone has any
> suggestions. I verified that the downstream msm8974 sources are using
> rpm smd to setup the interconnects for the msm bus:
> https://github.com/AICP/kernel_lge_hammerhead/blob/n7.1/arch/arm/mach-msm/msm_bus/msm_bus_rpm_smd.c#L153
> The only difference I noticed is that that upstream uses a 32 bit field
> for the 'value' field in drivers/interconnect/qcom/smd-rpm.c for
> qcom_icc_rpm_smd_send(), and downstream uses a 64 bit value instead.
> Changing that upstream doesn't make a difference.
> 
> Downstream msm8974 msm bus code:
> https://github.com/AICP/kernel_lge_hammerhead/blob/n7.1/arch/arm/mach-msm/msm_bus/msm_bus_board_8974.c
> 
> [1] Master IDs that I'm able to activate with qcom_icc_rpm_smd_send():
> 
>     HW ID    Name
>     -------------------------------
>      3       mas_mss_proc
>     18       slv_tcsr
>     21       slv_crypto_1_cfg
>     22       slv_imem_cfg
>     25       slv_boot_rom
>     29       slv_mpm
>     33       cnoc_to_snoc
>     34       slv_cnoc_onoc_cfg
>     35       slv_cnoc_mnoc_mmss_cfg
>     36       slv_cnoc_mnoc_cfg
>     37       slv_pnoc_cfg
>     38       slv_snoc_mpu_cfg
>     39       slv_snoc_cfg
>     40       slv_ebi1_dll_cfg
>     41       slv_phy_apu_cfg
>     42       slv_ebi1_phy_cfg
>     43       slv_rpm
>     44       slv_service_cnoc
>     52       mnoc_to_bimc
>     54       slv_display_cfg
> 
> [2] Master IDs where qcom_icc_rpm_smd_send() fails with -ENXIO. The
>     -ENXIO error comes from qcom_smd_rpm_callback() in
>     https://elixir.bootlin.com/linux/latest/source/drivers/soc/qcom/smd-rpm.c#L179
> 
>     HW ID    Name
>     -------------------------------
>      1       mas_ampss_m0
>      2       mas_ampss_m1
>      4       bimc_to_mnoc
>      5       bimc_to_snoc
>      6       slv_ebi_ch0
>      7       slv_ampss_l2
>      8       mas_rpm_inst
>      9       mas_rpm_data
>     10       mas_rpm_sys
>     11       mas_dehr
>     12       mas_qdss_dap
>     13       mas_spdm
>     14       mas_tic
>     15       slv_clk_ctl
>     16       slv_cnoc_mss
>     17       slv_security
>     19       slv_tlmm
>     20       slv_crypto_0_cfg
>     23       slv_message_ram
>     24       slv_bimc_cfg
>     26       slv_pmic_arb
>     27       slv_spdm_wrapper
>     28       slv_dehr_cfg
>     30       slv_qdss_cfg
>     31       slv_rbcpr_cfg
>     32       slv_rbcpr_qdss_apu_cfg
>     45       mas_graphics_3d
>     46       mas_jpeg
>     47       mas_mdp_port0
>     48       mas_video_p0
>     49       mas_video_p1
>     50       mas_vfe
>     51       mnoc_to_cnoc
>     53       slv_camera_cfg
>     55       slv_ocmem_cfg
>     56       slv_cpr_cfg
>     57       slv_cpr_xpu_cfg
> 
> [3] Clock warning on system startup:
> 
>     WARNING: CPU: 3 PID: 26 at drivers/clk/qcom/clk-rcg2.c:121 update_config+0xe8/0xf0
>     gfx3d_clk_src: rcg didn't update its configuration.
>     Modules linked in: msm qcom_spmi_vadc qcom_vadc_common pm8941_pwrkey qcom_spmi_iadc msm_vibrator brcmfmac qnoc_msm8974 icc_core inv_mpu6050_i2c(+) inv_mpu6050 brcmutil cfg80211 bq24190_charger tsl2772 rmi_i2c rmi_core icc_smd_rpm usb_f_rndis dm_mod
>     CPU: 3 PID: 26 Comm: kworker/3:0 Not tainted 5.3.0-rc4-next-20190816-00021-gd27e1e778708-dirty #148
>     Hardware name: Generic DT based system
>     Workqueue: events deferred_probe_work_func
>     [<c0312328>] (unwind_backtrace) from [<c030d618>] (show_stack+0x10/0x14)
>     [<c030d618>] (show_stack) from [<c0a8f8e4>] (dump_stack+0x78/0x8c)
>     [<c0a8f8e4>] (dump_stack) from [<c0321b64>] (__warn.part.0+0xb8/0xd4)
>     [<c0321b64>] (__warn.part.0) from [<c0321be8>] (warn_slowpath_fmt+0x68/0x94)
>     [<c0321be8>] (warn_slowpath_fmt) from [<c07262cc>] (update_config+0xe8/0xf0)
>     [<c07262cc>] (update_config) from [<c071d1cc>] (clk_change_rate+0x9c/0x594)
>     [<c071d1cc>] (clk_change_rate) from [<c071d850>] (clk_core_set_rate_nolock+0x18c/0x1d4)
>     [<c071d850>] (clk_core_set_rate_nolock) from [<c071d8c8>] (clk_set_rate+0x30/0x88)
>     [<c071d8c8>] (clk_set_rate) from [<bf16edf8>] (msm_gpu_pm_resume+0x104/0x168 [msm])
>     [<bf16edf8>] (msm_gpu_pm_resume [msm]) from [<c07d7c50>] (genpd_runtime_resume+0x9c/0x2a4)
>     [<c07d7c50>] (genpd_runtime_resume) from [<c07cd344>] (__rpm_callback+0x74/0x12c)
>     [<c07cd344>] (__rpm_callback) from [<c07cd41c>] (rpm_callback+0x20/0x80)
>     [<c07cd41c>] (rpm_callback) from [<c07ccf98>] (rpm_resume+0x640/0x814)
>     [<c07ccf98>] (rpm_resume) from [<c07cd1bc>] (__pm_runtime_resume+0x50/0x68)
>     [<c07cd1bc>] (__pm_runtime_resume) from [<bf11e498>] (adreno_load_gpu+0x50/0x154 [msm])
>     [<bf11e498>] (adreno_load_gpu [msm]) from [<bf1690d4>] (msm_open+0x80/0x94 [msm])
>     [<bf1690d4>] (msm_open [msm]) from [<c078b32c>] (drm_file_alloc+0x138/0x1f0)
>     [<c078b32c>] (drm_file_alloc) from [<c07aebdc>] (drm_client_init+0xa8/0x124)
>     [<c07aebdc>] (drm_client_init) from [<c0789700>] (drm_fb_helper_init.part.0+0x30/0x3c)
>     [<c0789700>] (drm_fb_helper_init.part.0) from [<bf1740fc>] (msm_fbdev_init+0x4c/0xb4 [msm])
>     [<bf1740fc>] (msm_fbdev_init [msm]) from [<bf169c90>] (msm_drm_bind+0x5d4/0x654 [msm])
>     [<bf169c90>] (msm_drm_bind [msm]) from [<c07b98b0>] (try_to_bring_up_master+0x1f8/0x2b4)
>     [<c07b98b0>] (try_to_bring_up_master) from [<c07b9a1c>] (__component_add+0xb0/0x174)
>     [<c07b9a1c>] (__component_add) from [<c07c29e8>] (platform_drv_probe+0x48/0x98)
>     [<c07c29e8>] (platform_drv_probe) from [<c07c0578>] (really_probe+0x24c/0x480)
>     [<c07c0578>] (really_probe) from [<c07c09a0>] (driver_probe_device+0xa0/0x1f8)
>     [<c07c09a0>] (driver_probe_device) from [<c07be5ec>] (bus_for_each_drv+0x84/0xd0)
>     [<c07be5ec>] (bus_for_each_drv) from [<c07c028c>] (__device_attach+0xe0/0x178)
>     [<c07c028c>] (__device_attach) from [<c07bf3c4>] (bus_probe_device+0x84/0x8c)
>     [<c07bf3c4>] (bus_probe_device) from [<c07bf91c>] (deferred_probe_work_func+0x84/0xc4)
>     [<c07bf91c>] (deferred_probe_work_func) from [<c033d2a8>] (process_one_work+0x1dc/0x538)
>     [<c033d2a8>] (process_one_work) from [<c033ebf8>] (worker_thread+0x44/0x508)
>     [<c033ebf8>] (worker_thread) from [<c0343370>] (kthread+0x120/0x150)
>     [<c0343370>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)

I haven't checked the docs, but we see pretty much the same problem on
subsequent platforms if things are now powered properly. And there's a
OXILI gdsc (power domain) which is fed by pm8841_s4 corner, according to
the downstream DT.

[..]
> diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
[..]
> +DEFINE_QNODE(mas_ampss_m0, MSM8974_BIMC_MAS_AMPSS_M0, 8, 0, -1);
> +DEFINE_QNODE(mas_ampss_m1, MSM8974_BIMC_MAS_AMPSS_M1, 8, 0, -1);
> +DEFINE_QNODE(mas_mss_proc, MSM8974_BIMC_MAS_MSS_PROC, 8, 1, -1);
> +DEFINE_QNODE(bimc_to_mnoc, MSM8974_BIMC_TO_MNOC, 8, 2, -1,
> +	     MSM8974_BIMC_SLV_EBI_CH0);

None of these looks excessive, so please ignore the 80-char rule to
improve readability.

> +DEFINE_QNODE(bimc_to_snoc, MSM8974_BIMC_TO_SNOC, 8, 3, 2,
> +	     MSM8974_SNOC_TO_BIMC, MSM8974_BIMC_SLV_EBI_CH0,
> +	     MSM8974_BIMC_MAS_AMPSS_M0);
> +DEFINE_QNODE(slv_ebi_ch0, MSM8974_BIMC_SLV_EBI_CH0, 8, -1, 0);
> +DEFINE_QNODE(slv_ampss_l2, MSM8974_BIMC_SLV_AMPSS_L2, 8, -1, 1);
> +
[..]
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct qcom_icc_desc *desc;
> +	struct icc_onecell_data *data;
> +	struct icc_provider *provider;
> +	struct qcom_icc_node **qnodes;
> +	struct qcom_icc_provider *qp;
> +	struct icc_node *node;
> +	size_t num_nodes, i;
> +	int ret;
> +
> +	/* wait for the RPM proxy */
> +	if (!qcom_icc_rpm_smd_available())
> +		return -EPROBE_DEFER;
> +
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	qnodes = desc->nodes;
> +	num_nodes = desc->num_nodes;
> +
> +	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
> +	if (!qp)
> +		return -ENOMEM;
> +
> +	data = devm_kcalloc(dev, num_nodes, sizeof(*node), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	qp->bus_clks = devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
> +				    GFP_KERNEL);
> +	if (!qp->bus_clks)
> +		return -ENOMEM;
> +
> +	qp->num_clks = ARRAY_SIZE(bus_clocks);
> +	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);

We should be able to turn these off when there are no active/enabled
paths passing by this particular bus. But let's postpone that problem.

> +	if (ret)
> +		return ret;
> +
> +	provider = &qp->provider;
> +	INIT_LIST_HEAD(&provider->nodes);
> +	provider->dev = dev;
> +	provider->set = qcom_icc_set;
> +	provider->aggregate = qcom_icc_aggregate;
> +	provider->xlate = of_icc_xlate_onecell;
> +	provider->data = data;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret) {
> +		dev_err(dev, "error adding interconnect provider: %d\n", ret);
> +		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);

Flip the order of clk_bulk_disable_unprepare() and icc_provider_del() in
the error path, inject a new label for the clk diable and replace this
with a goto err_disable_clks;

> +		return ret;
> +	}
> +
> +	for (i = 0; i < num_nodes; i++) {
> +		size_t j;
> +
> +		node = icc_node_create(qnodes[i]->id);
> +		if (IS_ERR(node)) {
> +			ret = PTR_ERR(node);
> +			goto err;
> +		}
> +
> +		node->name = qnodes[i]->name;
> +		node->data = qnodes[i];
> +		icc_node_add(node, provider);
> +
> +		dev_dbg(dev, "registered node %s\n", node->name);
> +
> +		/* populate links */
> +		for (j = 0; j < qnodes[i]->num_links; j++)
> +			icc_link_create(node, qnodes[i]->links[j]);
> +
> +		data->nodes[i] = node;
> +	}
> +	data->num_nodes = num_nodes;
> +
> +	platform_set_drvdata(pdev, qp);
> +
> +	return 0;
> +err:
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		icc_node_del(node);
> +		icc_node_destroy(node->id);
> +	}
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +	icc_provider_del(provider);
> +
> +	return ret;
> +}
> +
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
> +	struct icc_provider *provider = &qp->provider;
> +	struct icc_node *n;
> +
> +	list_for_each_entry(n, &provider->nodes, node_list) {
> +		icc_node_del(n);
> +		icc_node_destroy(n->id);
> +	}
> +	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
> +
> +	return icc_provider_del(provider);

It's nice when remove unrolls probe, so please flip the order of clk
disable and provider_del.

Regards,
Bjorn

> +}
> +
> +static const struct of_device_id msm8974_noc_of_match[] = {
> +	{ .compatible = "qcom,msm8974-bimc", .data = &msm8974_bimc},
> +	{ .compatible = "qcom,msm8974-cnoc", .data = &msm8974_cnoc},
> +	{ .compatible = "qcom,msm8974-mmssnoc", .data = &msm8974_mnoc},
> +	{ .compatible = "qcom,msm8974-ocmemnoc", .data = &msm8974_onoc},
> +	{ .compatible = "qcom,msm8974-pnoc", .data = &msm8974_pnoc},
> +	{ .compatible = "qcom,msm8974-snoc", .data = &msm8974_snoc},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, msm8974_noc_of_match);
> +
> +static struct platform_driver msm8974_noc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-msm8974",
> +		.of_match_table = msm8974_noc_of_match,
> +	},
> +};
> +module_platform_driver(msm8974_noc_driver);
> +MODULE_DESCRIPTION("Qualcomm MSM8974 NoC driver");
> +MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.21.0
> 
