Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBECC17D73F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 01:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCIABA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 20:01:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40153 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCIABA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2020 20:01:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so55035plk.7;
        Sun, 08 Mar 2020 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3EnAxyKfLmIeTAixSuTqX1IXT45nU66efv2U7XXuYc=;
        b=RtqGkW8D0lBvQQ1sOqiu79XEPqp89unTbnXFwtaYvcveKigLF/KlZGTz0DO4vh5SHd
         zeg4hPAJpHqoP3ndT0t7pN9bYJ+1+uZ0e6pDpJMr94o7K8HTGNSS44X4ZTQVNvgWaGcw
         85PzzEbOlMoFu5ShVPfPOcJpS3Tqo7Vzwv6bg1wcVfIFhdqqTB7YMYL7/gyQSesIGFaw
         MyZ99v/my8jEg2qfG9c0RS/bUjoQQEquW3aFAnQCucKJyjUq6nwz0hvVZnJquthvFrAY
         A1OKSZFrrGdQjPSli9AqjUOSHiocMIntGbECFd0IzhimZUysScGhXgJjN9Nj6G4OIXBo
         lPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V3EnAxyKfLmIeTAixSuTqX1IXT45nU66efv2U7XXuYc=;
        b=IFe/yvwMGKJqkGOTZ1OtY0BM3Jjn7WqH0Tc8Ohp3eIpEC7hYLHgvzoWtOsVtFbRDuL
         dUcD0SafGahR+5BsX5Z4P35cwveHi4SSrD6INekP0vdjkxzr4PJxd9BtMHr1xTu9NgGw
         JussUQu5YAcS1cM7SS+PiQ+embm40kEMyCIzHZwrX1E5oyhGXp2ChRpEAs07B/1Ybg1j
         O0i/E9vLjK1MQuZjJvY2x9H5NJErTmDFGuNuDh49FlGC4iFY7zNY3w/n4drM0SmiANfS
         +cDkcBd4JxHfwx3u9YK03Uv94azLl2x+1WEjJ+ygdnqjpsGq5HhimJ1Evc7qxBSqaSOx
         Pk/w==
X-Gm-Message-State: ANhLgQ1X6q0LhbZo1y2Hw3skraN6OMhOc8E9Z6EeBKiqnImFufD9MZK/
        rG+6fHDZpWJTGE7EQhqi664=
X-Google-Smtp-Source: ADFU+vu4FYIo7JhjPOzORuhZULdRbF7Q1TTpEpx3AW0ScSMIO4kLUQY7hIg+Ix4DxE/icqdb55/k/A==
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr16082073pjb.109.1583712058652;
        Sun, 08 Mar 2020 17:00:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12sm41739573pfm.165.2020.03.08.17.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 17:00:57 -0700 (PDT)
Subject: Re: [PATCH V2 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        dmitry.torokhov@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        wim@linux-watchdog.org, daniel.baluta@nxp.com,
        linux@rempel-privat.de, gregkh@linuxfoundation.org,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de, robh@kernel.org,
        yuehaibing@huawei.com, ronald@innovation.ch, krzk@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <63862bdf-874f-86d3-3bb5-b41185efffe1@roeck-us.net>
Date:   Sun, 8 Mar 2020 17:00:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/6/20 5:25 PM, Anson Huang wrote:
> Add stubs for those i.MX SCU APIs to make those modules depending
> on IMX_SCU can pass build when COMPILE_TEST is enabled.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> new patch.
> ---
>  include/linux/firmware/imx/ipc.h | 11 +++++++++++
>  include/linux/firmware/imx/sci.h | 19 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
> index 8910574..3fff0e2 100644
> --- a/include/linux/firmware/imx/ipc.h
> +++ b/include/linux/firmware/imx/ipc.h
> @@ -34,6 +34,7 @@ struct imx_sc_rpc_msg {
>  	uint8_t func;
>  };
>  
> +#ifdef CONFIG_IMX_SCU
>  /*
>   * This is an function to send an RPC message over an IPC channel.
>   * It is called by client-side SCFW API function shims.
> @@ -55,4 +56,14 @@ int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp);
>   * @return Returns an error code (0 = success, failed if < 0)
>   */
>  int imx_scu_get_handle(struct imx_sc_ipc **ipc);
> +#else
> +static inline int imx_scu_call_rpc(struct imx_sc_ipc *ipc, void *msg, bool have_resp)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_get_handle(struct imx_sc_ipc **ipc)
> +{
> +	return 0;
> +}
> +#endif
>  #endif /* _SC_IPC_H */
> diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index 17ba4e4..4688b60 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -16,8 +16,27 @@
>  #include <linux/firmware/imx/svc/misc.h>
>  #include <linux/firmware/imx/svc/pm.h>
>  
> +#ifdef CONFIG_IMX_SCU
>  int imx_scu_enable_general_irq_channel(struct device *dev);
>  int imx_scu_irq_register_notifier(struct notifier_block *nb);
>  int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
>  int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
> +#else
> +static inline int imx_scu_enable_general_irq_channel(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_irq_register_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
> +{
> +	return 0;
> +}

It would probably be more appropriate to return errors from the stub functions.

Guenter

> +#endif
>  #endif /* _SC_SCI_H */
> 

