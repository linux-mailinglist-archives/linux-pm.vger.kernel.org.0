Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0007523340
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfETMMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 08:12:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfETMMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 08:12:23 -0400
Received: from [192.168.178.167] ([109.104.33.162]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfHIZ-1gzevG1fCN-00gmnU; Mon, 20 May 2019 14:11:57 +0200
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-arm-kernel@lists.infradead.org, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
 <20190520104708.11980-4-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <ebc78880-418f-f507-021c-41295113e041@i2se.com>
Date:   Mon, 20 May 2019 14:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520104708.11980-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:lM2L/290UTJDhmpI0+jH1MnGxV1C8yzzLmFXizu9zQdwW9hbcVN
 L5Q7W9ERlIawKz0b+Nj9L0oyjt8cFmGtciMa3Esh26s8L7Ah03OWMVdi4CwDdlTlaXmnrGZ
 T+xn1+iKh1zSObQXRmz7cVGFDUVq3lodP0rV/E2N5Qpcp3aoWC5kxriB+WNAJSJJtV4hIKX
 QMtzS+Z32E5KvH9HO++CA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WSsZ//fILGY=:msl16chfnh30nn3b9H7z05
 X/LnHRyr3HPVEsQ7Hu2+RiqgOalBiWkN8SjU/2gN5Pf5DAZ21HH8oqMSeO8sUZvObl+CehiFp
 XgTSUDhGA5W1pHPEVXKrBmrJZxahvS+qmEgWIzmP5I/KaLHXorQKgsWP4kG/qZH0PFv0H9VeA
 sBetEO8OAoHGpDdvhTxwCc2nzbBYcXPHkQ2GeSbSmp5vm7G7CmwzOMOSu4QTMKEXLlPdbF+yb
 TMxRl3kPLetkp1m1TbX2IQAlQDaWFmrkW9REkPlh5r7xwMEHPT0ax9SfA3AES+Dz3duGnGa/k
 ILphX9+CPOZcHhtWUyoo9dZ27/Jvr3QxJgN9mecIW49sblz7qZ2SCYSxzOycPEiS5Q87m3REH
 dC/AYUSvs383juw4YZHhBl/3vTvUZiV8qeTBsX0i1krJ4GlgYmCW6ELMMThiBYC8FBzWrx3d/
 nXLiQWAidzbcuZJTAhteX7IOnDRPl8ftfEdgnXXnp6+ddMOcC/YUjxMb1q7ecFdqCfoLzWZKn
 hY9zYr1jKHxcJrDxSmQ3dHbg3epKPQgUL1oXQpuVonBnjPGsJDTFEO7MAykOo8XzuwEOP6EVD
 qp0I0XIVBb2ZGW5YT7JsvwbdM5inVlLfDtEHFYnwBgv13nBcWnzvWbyIc2offsqXxFV5SoNEk
 cSfVu7foUSRCZWnEAOA6wpI4ukHwzV88bsiYIJdOd6RWUobkmynr2vu/zaZQ2gMUVRnkkKVKy
 iz6kwiivMTR/p7uT55y5yPjswjJzEsM9AVbuDV/+0z1tvceu3G66FvB/euw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

the following comments applies only in case Eric is fine with the whole
approach.

On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
> Raspberry Pi's firmware, which runs in a dedicated processor, keeps
maybe we should clarify that the firmware is running in the VPU
> track of the board's temperature and voltage. It's resposible for
> scaling the CPU frequency whenever it deems the device reached an unsafe
> state. On top of that the firmware provides an interface which allows
> Linux to to query the clock's state or change it's frequency.
I think this requires a separate update of the devicetree binding.
>
> Being the sole user of the bcm2835 clock driver, this integrates the
> firmware interface into the clock driver and adds a first user: the CPU
> pll, also known as 'pllb'.

Please verify that the kernel still works (and this clock driver probe)
under the following conditions:

- CONFIG_RASPBERRYPI_FIRMWARE=n
- CONFIG_RASPBERRYPI_FIRMWARE=m
- older DTBs without patch #1

>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 274 ++++++++++++++++++++++++++++++++--
>  1 file changed, 259 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 5aea110672f3..ce5b16f3704e 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -35,6 +35,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <dt-bindings/clock/bcm2835.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
>  
>  #define CM_PASSWORD		0x5a000000
>  
> @@ -289,6 +290,30 @@
>  #define LOCK_TIMEOUT_NS		100000000
>  #define BCM2835_MAX_FB_RATE	1750000000u
>  
> +#define RPI_FIRMWARE_ARM_CLK_ID		0x000000003
> +#define RPI_FIRMWARE_STATE_ENABLE_BIT	0x1
> +#define RPI_FIRMWARE_STATE_WAIT_BIT	0x2
> +
> +/*
> + * Structure of the message passed to Raspberry Pi's firmware in order to
> + * change clock rates. The 'disable_turbo' option is only available to the ARM
> + * clock (pllb) which we enable by default as turbo mode will alter multiple
> + * clocks at once.
> + *
> + * Even though we're able to access the clock registers directly we're bound to
> + * use the firmware interface as the firmware ultimately takes care of
> + * mitigating overheating/undervoltage situations and we would be changing
> + * frequencies behind his back.
> + *
> + * For more information on the firmware interface check:
> + * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
> + */
> +struct bcm2835_firmware_prop {
> +       u32 id;
> +       u32 val;
> +       u32 disable_turbo;
> +} __packed;
> +
>  /*
>   * Names of clocks used within the driver that need to be replaced
>   * with an external parent's name.  This array is in the order that
> @@ -316,6 +341,8 @@ struct bcm2835_cprman {
>  	 */
>  	const char *real_parent_names[ARRAY_SIZE(cprman_parent_names)];
>  
> +	struct rpi_firmware *firmware;
> +
>  	/* Must be last */
>  	struct clk_hw_onecell_data onecell;
>  };
> @@ -424,6 +451,23 @@ struct bcm2835_pll_data {
>  	unsigned long max_fb_rate;
>  };
>  
> +struct bcm2835_fw_pll_data {
> +	const char *name;
> +	int firmware_clk_id;
> +	u32 flags;
> +
> +	unsigned long min_rate;
> +	unsigned long max_rate;
> +
> +	/*
> +	 * The rate provided to the firmware interface might not always match
> +	 * the clock subsystem's. For instance, in the case of the ARM cpu
> +	 * clock, even though the firmware ultimately edits 'pllb' it takes the
> +	 * expected 'pllb_arm' rate as it's input.
> +	 */
> +	unsigned int rate_rescale;
> +};
> +
>  struct bcm2835_pll_ana_bits {
>  	u32 mask0;
>  	u32 set0;
> @@ -505,6 +549,7 @@ struct bcm2835_pll {
>  	struct clk_hw hw;
>  	struct bcm2835_cprman *cprman;
>  	const struct bcm2835_pll_data *data;
> +	const struct bcm2835_fw_pll_data *fw_data;
>  };
>  
>  static int bcm2835_pll_is_on(struct clk_hw *hw)
> @@ -517,6 +562,41 @@ static int bcm2835_pll_is_on(struct clk_hw *hw)
>  		A2W_PLL_CTRL_PRST_DISABLE;
>  }
>  
> +static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
> +				      u32 clk, u32 *val)
> +{
> +	int ret;
> +	struct bcm2835_firmware_prop msg = {
> +		.id = clk,
> +		.val = *val,
> +		.disable_turbo = 1,
> +	};
> +
> +	ret = rpi_firmware_property(firmware, tag, &msg, sizeof(msg));
> +	if (ret)
> +		return ret;
> +
> +	*val = msg.val;
> +
> +	return 0;
> +}
> +
> +static int bcm2835_fw_pll_is_on(struct clk_hw *hw)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	u32 val = 0;
> +	int ret;
> +
> +	ret = raspberrypi_clock_property(cprman->firmware,
> +					 RPI_FIRMWARE_GET_CLOCK_STATE,
> +					 pll->fw_data->firmware_clk_id, &val);
> +	if (ret)
> +		return 0;
> +
> +	return !!(val & RPI_FIRMWARE_STATE_ENABLE_BIT);
> +}
> +
>  static void bcm2835_pll_choose_ndiv_and_fdiv(unsigned long rate,
>  					     unsigned long parent_rate,
>  					     u32 *ndiv, u32 *fdiv)
> @@ -547,16 +627,37 @@ static long bcm2835_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  				   unsigned long *parent_rate)
>  {
>  	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> -	const struct bcm2835_pll_data *data = pll->data;
>  	u32 ndiv, fdiv;
>  
> -	rate = clamp(rate, data->min_rate, data->max_rate);
> +	if (pll->data)
> +		rate = clamp(rate, pll->data->min_rate, pll->data->max_rate);
> +	else
> +		rate = clamp(rate, pll->fw_data->min_rate,
> +			     pll->fw_data->max_rate);
>  
>  	bcm2835_pll_choose_ndiv_and_fdiv(rate, *parent_rate, &ndiv, &fdiv);
>  
>  	return bcm2835_pll_rate_from_divisors(*parent_rate, ndiv, fdiv, 1);
>  }
>  
> +static unsigned long bcm2835_fw_pll_get_rate(struct clk_hw *hw,
> +					     unsigned long parent_rate)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	u32 val = 0;
> +	int ret;
> +
> +	ret = raspberrypi_clock_property(cprman->firmware,
> +					 RPI_FIRMWARE_GET_CLOCK_RATE,
> +					 pll->fw_data->firmware_clk_id,
> +					 &val);
> +	if (ret)
> +		return ret;
> +
> +	return val * pll->fw_data->rate_rescale;
> +}
> +
>  static unsigned long bcm2835_pll_get_rate(struct clk_hw *hw,
>  					  unsigned long parent_rate)
>  {
> @@ -584,6 +685,35 @@ static unsigned long bcm2835_pll_get_rate(struct clk_hw *hw,
>  	return bcm2835_pll_rate_from_divisors(parent_rate, ndiv, fdiv, pdiv);
>  }
>  
> +static int bcm2835_fw_pll_on(struct clk_hw *hw)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	u32 val;
> +	int ret;
> +
> +	val = RPI_FIRMWARE_STATE_ENABLE_BIT | RPI_FIRMWARE_STATE_WAIT_BIT;
> +
> +	ret = raspberrypi_clock_property(cprman->firmware,
> +					 RPI_FIRMWARE_SET_CLOCK_STATE,
> +					 pll->fw_data->firmware_clk_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void bcm2835_fw_pll_off(struct clk_hw *hw)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	u32 val = RPI_FIRMWARE_STATE_WAIT_BIT;
> +
> +	raspberrypi_clock_property(cprman->firmware,
> +				   RPI_FIRMWARE_SET_CLOCK_STATE,
> +				   pll->fw_data->firmware_clk_id, &val);
> +}
> +
>  static void bcm2835_pll_off(struct clk_hw *hw)
>  {
>  	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> @@ -651,6 +781,25 @@ bcm2835_pll_write_ana(struct bcm2835_cprman *cprman, u32 ana_reg_base, u32 *ana)
>  		cprman_write(cprman, ana_reg_base + i * 4, ana[i]);
>  }
>  
> +static int bcm2835_fw_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long parent_rate)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	u32 new_rate = rate / pll->fw_data->rate_rescale;
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	int ret;
> +
> +	ret = raspberrypi_clock_property(cprman->firmware,
> +					 RPI_FIRMWARE_SET_CLOCK_RATE,
> +					 pll->fw_data->firmware_clk_id,
> +					 &new_rate);
> +	if (ret)
> +		dev_err(cprman->dev, "Failed to change %s frequency: %d",
> +			clk_hw_get_name(hw), ret);
I think we should print this error only once or at least rate limited.
> +
> +	return ret;
> +}
> +
>  static int bcm2835_pll_set_rate(struct clk_hw *hw,
>  				unsigned long rate, unsigned long parent_rate)
>  {
> @@ -759,6 +908,15 @@ static const struct clk_ops bcm2835_pll_clk_ops = {
>  	.debug_init = bcm2835_pll_debug_init,
>  };
>  
> +static const struct clk_ops bcm2835_firmware_pll_clk_ops = {
> +	.is_prepared = bcm2835_fw_pll_is_on,
> +	.prepare = bcm2835_fw_pll_on,
> +	.unprepare = bcm2835_fw_pll_off,
> +	.recalc_rate = bcm2835_fw_pll_get_rate,
> +	.set_rate = bcm2835_fw_pll_set_rate,
> +	.round_rate = bcm2835_pll_round_rate,
> +};
> +
>  struct bcm2835_pll_divider {
>  	struct clk_divider div;
>  	struct bcm2835_cprman *cprman;
> @@ -1287,6 +1445,83 @@ static const struct clk_ops bcm2835_vpu_clock_clk_ops = {
>  	.debug_init = bcm2835_clock_debug_init,
>  };
>  
> +static int bcm2835_firmware_get_min_max_rates(struct bcm2835_cprman *cprman,
> +					      struct bcm2835_fw_pll_data *data)
> +{
> +	u32 min_rate = 0, max_rate = 0;
> +	int ret;
> +
> +	ret = raspberrypi_clock_property(cprman->firmware,
> +					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
> +					 data->firmware_clk_id,
> +					 &min_rate);
> +	if (ret) {
> +		dev_err(cprman->dev, "Failed to get %s min freq: %d\n",
> +			data->name, ret);
> +		return ret;
> +	}
> +
> +	ret = raspberrypi_clock_property(cprman->firmware,
> +					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
> +					 data->firmware_clk_id,
> +					 &max_rate);
> +	if (ret) {
> +		dev_err(cprman->dev, "Failed to get %s max freq: %d\n",
> +			data->name, ret);
> +		return ret;
> +	}
> +
> +	data->min_rate = min_rate * data->rate_rescale;
> +	data->max_rate = max_rate * data->rate_rescale;
> +
> +	dev_info(cprman->dev, "min %lu, max %lu\n", data->min_rate, data->max_rate);
> +	return 0;
> +}
> +
> +static struct clk_hw *bcm2835_register_fw_pll(struct bcm2835_cprman *cprman,
> +					const struct bcm2835_fw_pll_data *data)
> +{
> +	struct bcm2835_fw_pll_data *fw_data;
> +	struct clk_init_data init;
> +	struct bcm2835_pll *pll;
> +	int ret;
> +
> +	memset(&init, 0, sizeof(init));
> +
> +	/* All of the PLLs derive from the external oscillator. */
> +	init.parent_names = &cprman->real_parent_names[0];
> +	init.num_parents = 1;
> +	init.name = data->name;
> +	init.ops = &bcm2835_firmware_pll_clk_ops;
> +	init.flags = data->flags | CLK_IGNORE_UNUSED;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return NULL;
> +
> +	/*
> +	 * As the max and min rate values are firmware dependent we need a non
> +	 * constant version of struct bcm2835_fw_pll_data.
> +	 */
> +	fw_data = devm_kmemdup(cprman->dev, data, sizeof(*data),
> +				     GFP_KERNEL);
> +	if (!fw_data)
> +		return NULL;
> +
> +	ret = bcm2835_firmware_get_min_max_rates(cprman, fw_data);
> +	if (ret)
> +		return NULL;
> +
> +	pll->cprman = cprman;
> +	pll->hw.init = &init;
> +	pll->fw_data = fw_data;
> +
> +	ret = devm_clk_hw_register(cprman->dev, &pll->hw);
> +	if (ret)
> +		return NULL;
> +	return &pll->hw;
> +}
> +
>  static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
>  					   const struct bcm2835_pll_data *data)
>  {
> @@ -1462,6 +1697,9 @@ struct bcm2835_clk_desc {
>  #define REGISTER_PLL(...)	_REGISTER(&bcm2835_register_pll,	\
>  					  &(struct bcm2835_pll_data)	\
>  					  {__VA_ARGS__})
> +#define REGISTER_FW_PLL(...)	_REGISTER(&bcm2835_register_fw_pll,	\
> +					  &(struct bcm2835_fw_pll_data)	\
> +					  {__VA_ARGS__})
>  #define REGISTER_PLL_DIV(...)	_REGISTER(&bcm2835_register_pll_divider, \
>  					  &(struct bcm2835_pll_divider_data) \
>  					  {__VA_ARGS__})
> @@ -1654,21 +1892,11 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.flags = CLK_SET_RATE_PARENT),
>  
>  	/* PLLB is used for the ARM's clock. */
> -	[BCM2835_PLLB]		= REGISTER_PLL(
> +	[BCM2835_PLLB]		= REGISTER_FW_PLL(
>  		.name = "pllb",
> -		.cm_ctrl_reg = CM_PLLB,
> -		.a2w_ctrl_reg = A2W_PLLB_CTRL,
> -		.frac_reg = A2W_PLLB_FRAC,
> -		.ana_reg_base = A2W_PLLB_ANA0,
> -		.reference_enable_mask = A2W_XOSC_CTRL_PLLB_ENABLE,
> -		.lock_mask = CM_LOCK_FLOCKB,
>  		.flags = CLK_GET_RATE_NOCACHE,
> -
> -		.ana = &bcm2835_ana_default,
> -
> -		.min_rate = 600000000u,
> -		.max_rate = 3000000000u,
> -		.max_fb_rate = BCM2835_MAX_FB_RATE),
> +		.rate_rescale = 2,
> +		.firmware_clk_id = RPI_FIRMWARE_ARM_CLK_ID),
>  	[BCM2835_PLLB_ARM]	= REGISTER_PLL_DIV(
>  		.name = "pllb_arm",
>  		.source_pll = "pllb",
> @@ -2133,9 +2361,24 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	const struct bcm2835_clk_desc *desc;
>  	const size_t asize = ARRAY_SIZE(clk_desc_array);
> +	struct device_node *firmware_node;
> +	struct rpi_firmware *firmware;
>  	size_t i;
>  	int ret;
>  
> +	firmware_node = of_find_node_by_name(NULL, "firmware");
I prefer of_find_compatible_node() which is more specific.
> +	if (!firmware_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
The firmware node should be optional for the driver.
> +
> +	firmware = rpi_firmware_get(firmware_node);
> +	of_node_put(firmware_node);
> +	if (!firmware) {
> +		dev_err(dev, "Can't get raspberrypi's firmware\n");

For in case the driver for the Raspberry Pifirmware is enabled, we
shouldn't spam with errors here.

Stefan

