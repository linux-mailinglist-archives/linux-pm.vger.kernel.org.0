Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FABDDADB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 05:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfD2Drr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Apr 2019 23:47:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:24327 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfD2Drq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Apr 2019 23:47:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 20:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="319835562"
Received: from longweif-mobl.ccr.corp.intel.com ([10.255.28.210])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2019 20:47:44 -0700
Message-ID: <1556509663.2396.8.camel@intel.com>
Subject: Re: [PATCH next 23/25] thermal: Use dev_get_drvdata()
From:   Zhang Rui <rui.zhang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Date:   Mon, 29 Apr 2019 11:47:43 +0800
In-Reply-To: <20190423075020.173734-24-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
         <20190423075020.173734-24-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 二, 2019-04-23 at 15:50 +0800, Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  .../intel/int340x_thermal/processor_thermal_device.c      | 8 +-----
> --
>  drivers/thermal/st/stm_thermal.c                          | 6 ++----
>  2 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 8e1cf4d789be..4ad54b8d4778 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -81,8 +81,6 @@ static ssize_t
> power_limit_##index##_##suffix##_show(struct device *dev, \
>  					struct device_attribute
> *attr, \
>  					char *buf) \
>  { \
> -	struct pci_dev *pci_dev; \
> -	struct platform_device *pdev; \
>  	struct proc_thermal_device *proc_dev; \
>  	\
>  	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
> @@ -91,11 +89,7 @@ static ssize_t
> power_limit_##index##_##suffix##_show(struct device *dev, \
>  	} \
>  	\
>  	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
> -		pdev = to_platform_device(dev); \
> -		proc_dev = platform_get_drvdata(pdev); \
> -	} else { \
> -		pci_dev = to_pci_dev(dev); \
> -		proc_dev = pci_get_drvdata(pci_dev); \
> +		proc_dev = dev_get_drvdata(dev); \
>  	} \
>  	return sprintf(buf, "%lu\n",\
>  	(unsigned long)proc_dev->power_limits[index].suffix * 1000);
> \

Sumeet has a patch to fix the same issue, which has been in my tree
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
/?h=next&id=1948d498dcf680bc650391f23da2f97e59f9126d

Plus, the previous fix is wrong because proc_dev will be left
uninitialized if proc_thermal_emum_mode equals PROC_THERMAL_PCI.

thanks,
rui

> diff --git a/drivers/thermal/st/stm_thermal.c
> b/drivers/thermal/st/stm_thermal.c
> index bbd73c5a4a4e..cf9ddc52f30e 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -570,8 +570,7 @@ static int stm_thermal_prepare(struct
> stm_thermal_sensor *sensor)
>  static int stm_thermal_suspend(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor =
> platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_sensor_off(sensor);
>  	if (ret)
> @@ -585,8 +584,7 @@ static int stm_thermal_suspend(struct device
> *dev)
>  static int stm_thermal_resume(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor =
> platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_prepare(sensor);
>  	if (ret)
