Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB2445A19
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 19:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhKDTB3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 15:01:29 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38839 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKDTB3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 15:01:29 -0400
Received: by mail-ot1-f52.google.com with SMTP id c2-20020a056830348200b0055a46c889a8so9612085otu.5;
        Thu, 04 Nov 2021 11:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLKvPHk7AT6HIK5PlTcyCsOjSG94moArAkUSQWwW8dc=;
        b=TImzsnRb/fqdZRqyWPF3zb8WYnkv2QoR+PPhItFuBm1Xilvk5eXOnba7KhYKqVs2Fd
         Wx513sLlmlbL/sk0UR31c74xa1QE2QwJJjOJNJjt78/VPTZ4f7r550J8FljqouPJry70
         VWo5sXj97WcDgdZ3fLtLJKC9ErIO1C2ZtBcsuHPid11YDq5tErW2rtXXDhO5It387Lc/
         f3JZVsgIxRtHU4dJp+Uqo5zjrEU/plilFlDl2JiX+eYzCe6LyFUtPjphNmXkwl/TcCCh
         /2VNXiomZ8vAlnJHABVSsKDjEGIlNVE/+rwz2Roxpy/4LbVx8FJ2iwsgRbj/M8c5F1nw
         Z8Tw==
X-Gm-Message-State: AOAM530nIqgLghN3tgjOuZfpEbBX7aRnaIQS9WbQDItexTw8Sc3yUy9v
        mn8dfGWl5z+wXBMbOKGMuFE5GGAWVZgjxXmcSy/Em9to
X-Google-Smtp-Source: ABdhPJxubP7USfbkOKPvnIa2lijf2qUx1LObrK2bcOGTG304+NIeP0+vdSeiitCBU1C4XNh/3WaFUvuQZbrXUbuIom8=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr33171895otg.198.1636052330641;
 Thu, 04 Nov 2021 11:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211102105236.97469-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20211102105236.97469-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Nov 2021 19:58:38 +0100
Message-ID: <CAJZ5v0hRi+tFnCANDcMBkHs9nZxr8yh8afYtkvPhkBHzAaciJQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/int340x: processor_thermal: Suppot 64 bit
 RFIM responses
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 2, 2021 at 11:52 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Some of the RFIM mail box command returns 64 bit values. So enhance
> mailbox interface to return 64 bit values and use them for RFIM
> commands.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: 5d6fbc96bd36 ("thermal/drivers/int340x: processor_thermal: Export additional attributes")
> ---
>  .../processor_thermal_device.h                |  2 +-
>  .../int340x_thermal/processor_thermal_mbox.c  | 22 +++++++++++--------
>  .../int340x_thermal/processor_thermal_rfim.c  | 10 ++++-----
>  3 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 5a1cfe4864f1..2aae91e7b13d 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -80,7 +80,7 @@ void proc_thermal_rfim_remove(struct pci_dev *pdev);
>  int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
>  void proc_thermal_mbox_remove(struct pci_dev *pdev);
>
> -int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp);
> +int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u64 *cmd_resp);
>  int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
>  void proc_thermal_remove(struct proc_thermal_device *proc_priv);
>  int proc_thermal_resume(struct device *dev);
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> index 59e93b04f0a9..a86521973dad 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
> @@ -23,7 +23,7 @@
>
>  static DEFINE_MUTEX(mbox_lock);
>
> -static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
> +static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u64 *cmd_resp)
>  {
>         struct proc_thermal_device *proc_priv;
>         u32 retries, data;
> @@ -68,12 +68,16 @@ static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cm
>                         goto unlock_mbox;
>                 }
>
> -               if (cmd_id == MBOX_CMD_WORKLOAD_TYPE_READ) {
> -                       data = readl((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
> -                       *cmd_resp = data & 0xff;
> -               }
> -
>                 ret = 0;
> +
> +               if (!cmd_resp)
> +                       break;
> +
> +               if (cmd_id == MBOX_CMD_WORKLOAD_TYPE_READ)
> +                       *cmd_resp = readl((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
> +               else
> +                       *cmd_resp = readq((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
> +
>                 break;
>         } while (--retries);
>
> @@ -82,7 +86,7 @@ static int send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cm
>         return ret;
>  }
>
> -int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u32 *cmd_resp)
> +int processor_thermal_send_mbox_cmd(struct pci_dev *pdev, u16 cmd_id, u32 cmd_data, u64 *cmd_resp)
>  {
>         return send_mbox_cmd(pdev, cmd_id, cmd_data, cmd_resp);
>  }
> @@ -153,7 +157,7 @@ static ssize_t workload_type_show(struct device *dev,
>                                    char *buf)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
> -       u32 cmd_resp;
> +       u64 cmd_resp;
>         int ret;
>
>         ret = send_mbox_cmd(pdev, MBOX_CMD_WORKLOAD_TYPE_READ, 0, &cmd_resp);
> @@ -187,7 +191,7 @@ static bool workload_req_created;
>
>  int proc_thermal_mbox_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
>  {
> -       u32 cmd_resp;
> +       u64 cmd_resp;
>         int ret;
>
>         /* Check if there is a mailbox support, if fails return success */
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 2b8a3235d518..b25b54d4bac1 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -195,7 +195,7 @@ static ssize_t rfi_restriction_store(struct device *dev,
>                                      const char *buf, size_t count)
>  {
>         u16 cmd_id = 0x0008;
> -       u32 cmd_resp;
> +       u64 cmd_resp;
>         u32 input;
>         int ret;
>
> @@ -215,14 +215,14 @@ static ssize_t rfi_restriction_show(struct device *dev,
>                                     char *buf)
>  {
>         u16 cmd_id = 0x0007;
> -       u32 cmd_resp;
> +       u64 cmd_resp;
>         int ret;
>
>         ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
>         if (ret)
>                 return ret;
>
> -       return sprintf(buf, "%u\n", cmd_resp);
> +       return sprintf(buf, "%llu\n", cmd_resp);
>  }
>
>  static ssize_t ddr_data_rate_show(struct device *dev,
> @@ -230,14 +230,14 @@ static ssize_t ddr_data_rate_show(struct device *dev,
>                                   char *buf)
>  {
>         u16 cmd_id = 0x0107;
> -       u32 cmd_resp;
> +       u64 cmd_resp;
>         int ret;
>
>         ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
>         if (ret)
>                 return ret;
>
> -       return sprintf(buf, "%u\n", cmd_resp);
> +       return sprintf(buf, "%llu\n", cmd_resp);
>  }
>
>  static DEVICE_ATTR_RW(rfi_restriction);
> --

Applied as 5.16-rc material, thanks!
