Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD62679BA8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 15:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjAXOW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 09:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjAXOW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 09:22:57 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DCA975C;
        Tue, 24 Jan 2023 06:22:54 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id bk15so39348229ejb.9;
        Tue, 24 Jan 2023 06:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPc3U4Ryl/mKkmIF4TQfdebgB3N7QRmFQxK1chu2YlA=;
        b=2tmFWYrKzssuM4zOjzpJ0mYZwmNXPYjaD1JnTovhCIY3n6vdC7f6TS/DxXRlnJ6QAU
         1FmBl/vsfVnIVTHnkDGA1JTFWCP7Xw4foCDkdB4YjakMVkmYJaZcakX8nZbavOmpgbSO
         VFyhePz8enIMZL1TlFG7XQmHffv24gh93jVf7ioS/reMigtR53fqjCJc028pgIYddytv
         YtEBzN+oOixqBBPBe5TXmmIbsMzTj/CmzzYKYXfCg1VXCxHYzK5reyrTdMT0HZ/VQZlP
         DO39A+IV0HuanVP8qw7PjH/A+IaZ1UWVttJJPZDtJIBMhaoV31mM/8kDhOTCjf2lXMZQ
         aBIQ==
X-Gm-Message-State: AFqh2koC/Qq/Q30rWE/fpIbpComk58uWwbUShGwmhRuHjt0U0lcjS5wr
        oDIXkmOJLpjw2b0+5u/1Y8ymVJq/KnF32ylDpcI+IYCpqlU=
X-Google-Smtp-Source: AMrXdXu+rGhC8WBT9vbLib8ObZ1uG95VEsfdO04HPSRxNtifH6eat1pm5i4fopQPo622QseNL0mFWmhEmRSArGHIzfE=
X-Received: by 2002:a17:906:4e9a:b0:84d:4dc6:1c08 with SMTP id
 v26-20020a1709064e9a00b0084d4dc61c08mr4678764eju.421.1674570173334; Tue, 24
 Jan 2023 06:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20230123163046.358879-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230123163046.358879-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 15:22:41 +0100
Message-ID: <CAJZ5v0iK-ob4Mhh-Upq01gq6SPsYuAD22E-o0zwcoL1hLiP3JQ@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: int340x_thermal: Add production mode attribute
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 23, 2023 at 5:31 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> It is possible that the system manufacturer locks down thermal tuning
> beyond what is usually done on the given platform. In that case user
> space calibration tools should not try to adjust the thermal
> configuration of the system.
>
> To allow user space to check if that is the case, add a new sysfs
> attribute "production_mode" that will be present when the ACPI DCFG
> method is present under the INT3400 device object in the ACPI Namespace.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v3:
> Build warning reported by for missing static
> Reported-by: kernel test robot <lkp@intel.com>
>
> v2
> Addressed comments from Rafael:
> - Updated commit excatly same as Rafael wrote
> - Removed production_mode_support bool
> - Use sysfs_emit
> - Update documentation
>
>  .../driver-api/thermal/intel_dptf.rst         |  3 ++
>  .../intel/int340x_thermal/int3400_thermal.c   | 48 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> index 372bdb4d04c6..f5c193cccbda 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -84,6 +84,9 @@ DPTF ACPI Drivers interface
>         https:/github.com/intel/thermal_daemon for decoding
>         thermal table.
>
> +``production_mode`` (RO)
> +       When different from zero, manufacturer locked thermal configuration
> +       from further changes.
>
>  ACPI Thermal Relationship table interface
>  ------------------------------------------
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index db8a6f63657d..23ea21238bbd 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -60,6 +60,7 @@ struct int3400_thermal_priv {
>         int odvp_count;
>         int *odvp;
>         u32 os_uuid_mask;
> +       int production_mode;
>         struct odvp_attr *odvp_attrs;
>  };
>
> @@ -315,6 +316,44 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
>         return result;
>  }
>
> +static ssize_t production_mode_show(struct device *dev, struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%d\n", priv->production_mode);
> +}
> +
> +static DEVICE_ATTR_RO(production_mode);
> +
> +static int production_mode_init(struct int3400_thermal_priv *priv)
> +{
> +       unsigned long long mode;
> +       acpi_status status;
> +       int ret;
> +
> +       priv->production_mode = -1;
> +
> +       status = acpi_evaluate_integer(priv->adev->handle, "DCFG", NULL, &mode);
> +       /* If the method is not present, this is not an error */
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       ret = sysfs_create_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);
> +       if (ret)
> +               return ret;
> +
> +       priv->production_mode = mode;
> +
> +       return 0;
> +}
> +
> +static void production_mode_exit(struct int3400_thermal_priv *priv)
> +{
> +       if (priv->production_mode >= 0)
> +               sysfs_remove_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);

Isn't it OK to call sysfs_remove_file() if the given attribute is not there?

If so, the above check is unnecessary and the assignment to -1 above
too (as this is the only place where the value is tested).

> +}
> +
>  static ssize_t odvp_show(struct device *dev, struct device_attribute *attr,
>                          char *buf)
>  {
> @@ -610,8 +649,15 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>         if (result)
>                 goto free_sysfs;
>
> +       result = production_mode_init(priv);
> +       if (result)
> +               goto free_notify;
> +
>         return 0;
>
> +free_notify:
> +       acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY,
> +                                  int3400_notify);
>  free_sysfs:
>         cleanup_odvp(priv);
>         if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> @@ -638,6 +684,8 @@ static int int3400_thermal_remove(struct platform_device *pdev)
>  {
>         struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
>
> +       production_mode_exit(priv);
> +
>         acpi_remove_notify_handler(
>                         priv->adev->handle, ACPI_DEVICE_NOTIFY,
>                         int3400_notify);
> --
