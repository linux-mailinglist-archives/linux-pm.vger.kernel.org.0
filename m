Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0401DE479
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 12:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgEVKc4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 06:32:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53454 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728489AbgEVKcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 06:32:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590143573; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=A8SlPMLfIto7aH1IbEyCSxe/GdgfERUkQfAQLAPPW48=;
 b=kjV5R0oNtOsffj5igwQefqnZ2tZ2LGjhGBtQ70SPHBrnMdt15ersvGBK3ph3308kpKQgBdqk
 7kH0wBQDHOuj276CzFlaDT+YMjPEYrp5VARCd2eC0s0ssGrOfJonp2OX67ggGlpFgPNK1HRG
 M5PrdGl8vbOYu9WwZm2rpuBJyTQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ec7aa5582c96b5d3b8bb4d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 10:32:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59DECC433C6; Fri, 22 May 2020 10:32:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF4ADC433C8;
        Fri, 22 May 2020 10:32:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 May 2020 16:02:51 +0530
From:   manafm@codeaurora.org
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] drivers: thermal: tsens: Add zeroc interrupt
 support
In-Reply-To: <CAHLCerNct=4HGXiwxWaupBTm15+Z2yY1RW_BRBgiGGAk62svJw@mail.gmail.com>
References: <20200517104627.29501-1-manafm@codeaurora.org>
 <20200517104627.29501-2-manafm@codeaurora.org>
 <CAHLCerNct=4HGXiwxWaupBTm15+Z2yY1RW_BRBgiGGAk62svJw@mail.gmail.com>
Message-ID: <0518a5b909caddf4c61bb8e4f53868e5@codeaurora.org>
X-Sender: manafm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-20 17:12, Amit Kucheria wrote:
> On Sun, May 17, 2020 at 4:17 PM Manaf Meethalavalappu Pallikunhi
> <manafm@codeaurora.org> wrote:
>> 
>> TSENS IP v2.6+ adds zeroc interrupt support. It triggers set
> 
> As I re-read through these patches, shouldn't we just call it the
> "cold" interrupt?
Renamed zeroc with cold everywhere
> 
>> interrupt when aggregated minimum temperature of all TSENS falls
>> below zeroc preset threshold and triggers reset interrupt when
> 
> Again, cold would just capture the intent much better given that it
> doesn't even triggered at zero but at 5 degrees. And this value could
> change in firmware.
> 
>> aggregated minimum temperature of all TSENS crosses above reset
>> threshold. Add support for this interrupt in the driver.
>> 
>> It adds another sensor to the of-thermal along with all individual
>> TSENS. It enables to add any mitigation for zeroc interrupt.
>> 
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <manafm@codeaurora.org>
>> ---
>>  drivers/thermal/qcom/tsens-v2.c |   5 ++
>>  drivers/thermal/qcom/tsens.c    | 107 
>> +++++++++++++++++++++++++++++++-
>>  drivers/thermal/qcom/tsens.h    |  10 +++
>>  3 files changed, 120 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/thermal/qcom/tsens-v2.c 
>> b/drivers/thermal/qcom/tsens-v2.c
>> index b293ed32174b..8f30b859ab22 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -23,6 +23,7 @@
>>  #define TM_Sn_UPPER_LOWER_THRESHOLD_OFF 0x0020
>>  #define TM_Sn_CRITICAL_THRESHOLD_OFF   0x0060
>>  #define TM_Sn_STATUS_OFF               0x00a0
>> +#define TM_ZEROC_INT_STATUS_OFF                0x00e0
>>  #define TM_TRDY_OFF                    0x00e4
>>  #define TM_WDOG_LOG_OFF                0x013c
>> 
>> @@ -86,6 +87,9 @@ static const struct reg_field 
>> tsens_v2_regfields[MAX_REGFIELDS] = {
>>         REG_FIELD_FOR_EACH_SENSOR16(CRITICAL_STATUS, TM_Sn_STATUS_OFF, 
>> 19,  19),
>>         REG_FIELD_FOR_EACH_SENSOR16(MAX_STATUS,      TM_Sn_STATUS_OFF, 
>> 20,  20),
>> 
>> +       /* ZEROC INTERRUPT STATUS */
>> +       [ZEROC_STATUS] = REG_FIELD(TM_ZEROC_INT_STATUS_OFF, 0, 0),
>> +
>>         /* TRDY: 1=ready, 0=in progress */
>>         [TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>>  };
>> @@ -93,6 +97,7 @@ static const struct reg_field 
>> tsens_v2_regfields[MAX_REGFIELDS] = {
>>  static const struct tsens_ops ops_generic_v2 = {
>>         .init           = init_common,
>>         .get_temp       = get_temp_tsens_valid,
>> +       .get_zeroc_status  = get_tsens_zeroc_status,
>>  };
>> 
>>  struct tsens_plat_data data_tsens_v2 = {
>> diff --git a/drivers/thermal/qcom/tsens.c 
>> b/drivers/thermal/qcom/tsens.c
>> index 8d3e94d2a9ed..dd0172f05eb6 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -205,7 +205,8 @@ static void tsens_set_interrupt_v1(struct 
>> tsens_priv *priv, u32 hw_id,
>>                 index = LOW_INT_CLEAR_0 + hw_id;
>>                 break;
>>         case CRITICAL:
>> -               /* No critical interrupts before v2 */
>> +       case ZEROC:
>> +               /* No critical and zeroc interrupts before v2 */
>>                 return;
>>         }
>>         regmap_field_write(priv->rf[index], enable ? 0 : 1);
>> @@ -236,6 +237,9 @@ static void tsens_set_interrupt_v2(struct 
>> tsens_priv *priv, u32 hw_id,
>>                 index_mask  = CRIT_INT_MASK_0 + hw_id;
>>                 index_clear = CRIT_INT_CLEAR_0 + hw_id;
>>                 break;
>> +       case ZEROC:
>> +               /* Nothing to handle for zeroc interrupt */
>> +               return;
>>         }
>> 
>>         if (enable) {
>> @@ -367,6 +371,35 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, 
>> enum tsens_ver ver)
>>         return 0;
>>  }
>> 
>> +/**
>> + * tsens_zeroc_irq_thread - Threaded interrupt handler for zeroc 
>> interrupt
>> + * @irq: irq number
>> + * @data: tsens controller private data
>> + *
>> + * Whenever interrupt triggers notify thermal framework using
>> + * thermal_zone_device_update().
>> + *
>> + * Return: IRQ_HANDLED
>> + */
>> +
>> +irqreturn_t tsens_zeroc_irq_thread(int irq, void *data)
>> +{
>> +       struct tsens_priv *priv = data;
>> +       struct tsens_sensor *s = &priv->sensor[priv->num_sensors];
>> +       int temp, ret;
>> +
>> +       ret = regmap_field_read(priv->rf[ZEROC_STATUS], &temp);
>> +       if (ret)
>> +               return ret;
>> +
>> +       dev_dbg(priv->dev, "[%u] %s: zeroc interrupt is %s\n",
>> +               s->hw_id, __func__, temp ? "triggered" : "cleared");
> 
> Rename temp to cold or something similar since you're not really
> returning temperature but a boolean state on whether we're in cold
> zone or not.
Renamed zeroc with cold everywhere
> 
>> +
>> +       thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>>  /**
>>   * tsens_critical_irq_thread() - Threaded handler for critical 
>> interrupts
>>   * @irq: irq number
>> @@ -575,6 +608,20 @@ void tsens_disable_irq(struct tsens_priv *priv)
>>         regmap_field_write(priv->rf[INT_EN], 0);
>>  }
>> 
>> +int get_tsens_zeroc_status(const struct tsens_sensor *s, int *temp)
>> +{
>> +       struct tsens_priv *priv = s->priv;
>> +       int last_temp = 0, ret;
>> +
>> +       ret = regmap_field_read(priv->rf[ZEROC_STATUS], &last_temp);
>> +       if (ret)
>> +               return ret;
>> +
>> +       *temp = last_temp;
> 
> same here. Don't use temp and last_temp. Use cold and prev_cold, for 
> example.
Done
> 
>> +
>> +       return 0;
>> +}
>> +
>>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>>  {
>>         struct tsens_priv *priv = s->priv;
>> @@ -843,6 +890,19 @@ int __init init_common(struct tsens_priv *priv)
>>                 regmap_field_write(priv->rf[CC_MON_MASK], 1);
>>         }
>> 
>> +       if (tsens_version(priv) > VER_1_X &&  ver_minor > 5) {
>> +               /* ZEROC interrupt is present only on v2.6+ */
>> +               priv->feat->zeroc_int = 1;
>> +               priv->rf[ZEROC_STATUS] = devm_regmap_field_alloc(
>> +                                               dev,
>> +                                               priv->tm_map,
>> +                                               
>> priv->fields[ZEROC_STATUS]);
>> +               if (IS_ERR(priv->rf[ZEROC_STATUS])) {
>> +                       ret = PTR_ERR(priv->rf[ZEROC_STATUS]);
>> +                       goto err_put_device;
>> +               }
>> +       }
>> +
>>         spin_lock_init(&priv->ul_lock);
>>         tsens_enable_irq(priv);
>>         tsens_debug_init(op);
>> @@ -852,6 +912,17 @@ int __init init_common(struct tsens_priv *priv)
>>         return ret;
>>  }
>> 
>> +static int tsens_zeroc_get_temp(void *data, int *temp)
> 
> Add kernel doc to this function since it doesn't return temperature,
> but a cold state, 0 or 1, on success.
Done
> 
> One question: You need to poll this value from userspace, right? For
> the userspace interface being discussed on the list currently, you
> would still not get automatic notifications for this interrupt unless
> you plan to add trip points that will cause thermal core to trigger
> userspace events.
As discussed, we will be adding a thermal zone devicetree node with trip
threshold equal to 1 which could use either userspace or stepwise 
governor.
I will update thermal zone example in binding doc.
> 
>> +{
>> +       struct tsens_sensor *s = data;
>> +       struct tsens_priv *priv = s->priv;
>> +
>> +       if (priv->ops->get_zeroc_status)
>> +               return priv->ops->get_zeroc_status(s, temp);
>> +
>> +       return -ENOTSUPP;
>> +}
>> +
>>  static int tsens_get_temp(void *data, int *temp)
>>  {
>>         struct tsens_sensor *s = data;
>> @@ -923,6 +994,10 @@ static const struct thermal_zone_of_device_ops 
>> tsens_of_ops = {
>>         .set_trips = tsens_set_trips,
>>  };
>> 
>> +static const struct thermal_zone_of_device_ops tsens_zeroc_of_ops = {
>> +       .get_temp = tsens_zeroc_get_temp,
>> +};
>> +
>>  static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>>                               irq_handler_t thread_fn)
>>  {
>> @@ -980,6 +1055,21 @@ static int tsens_register(struct tsens_priv 
>> *priv)
>>                 ret = tsens_register_irq(priv, "critical",
>>                                          tsens_critical_irq_thread);
>> 
>> +       if (priv->feat->zeroc_int && priv->zeroc_en) {
>> +               priv->sensor[priv->num_sensors].priv = priv;
>> +               tzd = devm_thermal_zone_of_sensor_register(priv->dev,
>> +                                       
>> priv->sensor[priv->num_sensors].hw_id,
>> +                                       
>> &priv->sensor[priv->num_sensors],
>> +                                       &tsens_zeroc_of_ops);
>> +               if (IS_ERR(tzd)) {
>> +                       ret = 0;
>> +                       return ret;
>> +               }
>> +
>> +               priv->sensor[priv->num_sensors].tzd = tzd;
>> +               ret = tsens_register_irq(priv, "zeroc", 
>> tsens_zeroc_irq_thread);
>> +       }
>> +
>>         return ret;
>>  }
>> 
>> @@ -992,6 +1082,7 @@ static int tsens_probe(struct platform_device 
>> *pdev)
>>         const struct tsens_plat_data *data;
>>         const struct of_device_id *id;
>>         u32 num_sensors;
>> +       bool zeroc_en = false;
>> 
>>         if (pdev->dev.of_node)
>>                 dev = &pdev->dev;
>> @@ -1016,6 +1107,12 @@ static int tsens_probe(struct platform_device 
>> *pdev)
>>                 return -EINVAL;
>>         }
>> 
>> +       /* Check whether zeroc interrupt is enabled or not */
>> +       if (platform_get_irq_byname(pdev, "zeroc") > 0) {
>> +               zeroc_en = true;
> 
> This check can be done in tsens_register_irq() from tsens_register. It
> is OK to have an extra struct tsens_sensor allocated even on platforms
> that don't have it.
Done
> 
>> +               num_sensors++;
>> +       }
>> +
>>         priv = devm_kzalloc(dev,
>>                              struct_size(priv, sensor, num_sensors),
> 
> make this num_sensors + 1 to account for the zeroc virtual sensor. See 
> below.
Changed this code in v3
> 
>>                              GFP_KERNEL);
>> @@ -1023,7 +1120,7 @@ static int tsens_probe(struct platform_device 
>> *pdev)
>>                 return -ENOMEM;
>> 
>>         priv->dev = dev;
>> -       priv->num_sensors = num_sensors;
>> +       priv->num_sensors = zeroc_en ? num_sensors - 1 : num_sensors;
>>         priv->ops = data->ops;
>>         for (i = 0;  i < priv->num_sensors; i++) {
>>                 if (data->hw_ids)
>> @@ -1031,6 +1128,12 @@ static int tsens_probe(struct platform_device 
>> *pdev)
>>                 else
>>                         priv->sensor[i].hw_id = i;
>>         }
>> +
>> +       if (zeroc_en) {
>> +               priv->zeroc_en = zeroc_en;
>> +               priv->sensor[num_sensors].hw_id = 
>> data->feat->max_sensors;
> 
> This is going to break as soon as we have a platform that actually
> uses all 16 sensors. i.e. you won't have a spare one to use if
> num_sensors >= max_sensors.
> 
> I think you should introduce a new member 'struct tsens_sensor
> zeroc_sensor' in tsens_priv and avoid playing with num_sensors
> completely.
Removed this code in v3
> 
>> +       }
>> +
>>         priv->feat = data->feat;
>>         priv->fields = data->fields;
>> 
>> diff --git a/drivers/thermal/qcom/tsens.h 
>> b/drivers/thermal/qcom/tsens.h
>> index 59d01162c66a..34d24332b320 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -34,6 +34,7 @@ enum tsens_irq_type {
>>         LOWER,
>>         UPPER,
>>         CRITICAL,
>> +       ZEROC,
>>  };
>> 
>>  /**
>> @@ -64,6 +65,7 @@ struct tsens_sensor {
>>   * @suspend: Function to suspend the tsens device
>>   * @resume: Function to resume the tsens device
>>   * @get_trend: Function to get the thermal/temp trend
>> + * @get_zeroc_status: Function to get the zeroc interrupt status
>>   */
>>  struct tsens_ops {
>>         /* mandatory callbacks */
>> @@ -76,6 +78,7 @@ struct tsens_ops {
>>         int (*suspend)(struct tsens_priv *priv);
>>         int (*resume)(struct tsens_priv *priv);
>>         int (*get_trend)(struct tsens_sensor *s, enum thermal_trend 
>> *trend);
>> +       int (*get_zeroc_status)(const struct tsens_sensor *s, int 
>> *temp);
> 
> this fn doesn't return temp, but a boolean status of whether we're in
> cold zone or not. Replace 'int *temp' with 'boolean *zeroc'?
Updated
> 
>>  };
>> 
>>  #define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, 
>> _stopbit) \
>> @@ -485,6 +488,8 @@ enum regfield_ids {
>>         MAX_STATUS_14,
>>         MAX_STATUS_15,
>> 
>> +       ZEROC_STATUS,   /* ZEROC INTERRUPT status */
> 
> Indent comment at same level as others above it
Done
> 
> 
>> +
>>         /* Keep last */
>>         MAX_REGFIELDS
>>  };
>> @@ -497,6 +502,7 @@ enum regfield_ids {
>>   * @srot_split: does the IP neatly splits the register space into 
>> SROT and TM,
>>   *              with SROT only being available to secure boot 
>> firmware?
>>   * @has_watchdog: does this IP support watchdog functionality?
>> + * @zeroc_int: does this IP support ZEROC interrupt ?
>>   * @max_sensors: maximum sensors supported by this version of the IP
>>   */
>>  struct tsens_features {
>> @@ -505,6 +511,7 @@ struct tsens_features {
>>         unsigned int adc:1;
>>         unsigned int srot_split:1;
>>         unsigned int has_watchdog:1;
>> +       unsigned int zeroc_int:1;
>>         unsigned int max_sensors;
>>  };
>> 
>> @@ -549,6 +556,7 @@ struct tsens_context {
>>   * @feat: features of the IP
>>   * @fields: bitfield locations
>>   * @ops: pointer to list of callbacks supported by this device
>> + * @zeroc_en: variable to check zeroc interrupt sensor is enabled or 
>> not
>>   * @debug_root: pointer to debugfs dentry for all tsens
>>   * @debug: pointer to debugfs dentry for tsens controller
>>   * @sensor: list of sensors attached to this device
>> @@ -568,6 +576,7 @@ struct tsens_priv {
>>         struct tsens_features           *feat;
>>         const struct reg_field          *fields;
>>         const struct tsens_ops          *ops;
>> +       bool                            zeroc_en;
>> 
>>         struct dentry                   *debug_root;
>>         struct dentry                   *debug;
>> @@ -580,6 +589,7 @@ void compute_intercept_slope(struct tsens_priv 
>> *priv, u32 *pt1, u32 *pt2, u32 mo
>>  int init_common(struct tsens_priv *priv);
>>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>>  int get_temp_common(const struct tsens_sensor *s, int *temp);
>> +int get_tsens_zeroc_status(const struct tsens_sensor *s, int *temp);
>> 
>>  /* TSENS target */
>>  extern struct tsens_plat_data data_8960;
>> --
>> 2.26.2
