Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE45A51DC43
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 17:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442998AbiEFPkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442988AbiEFPkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 11:40:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B85799C
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 08:36:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so11130180pjb.3
        for <linux-pm@vger.kernel.org>; Fri, 06 May 2022 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fEYFgdkNMrJlRdSBBi7FogRAnDEV7m+tJQA0hKmqpU=;
        b=BmapRtXoha9V3b/4Mtj4vQpVG4h1674p13TWaBL7cf34QDJAcqW8KvilHPqNsb78Tr
         Ktq0XyFJ7oZGYWDEfnqaAv7jy6wiMKwlSmevaWeidcESeAFlMfBtFRuzZiQ5oLH263nn
         q1WIvmUsu9+UoBomBhSVKjCcJWbApE5b3fJgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fEYFgdkNMrJlRdSBBi7FogRAnDEV7m+tJQA0hKmqpU=;
        b=YfexU/eKkt8cFyPMpChyewxHQr/OI3J7ejHqSplYVJVZjreoLFrzi5jmjjmGU4DmQE
         td16inwrI7VrvQIfWVyCNTvlH7aWlr3qCeqIzn3QkWE/QL0q2yO2lVVCtny3h/WR9qrm
         nVoMZhiZq7fdd2nkFxDvmi9xFSZQk5ynds/7kjDw2/WBSy4n+FH1fnmHXTDaqga1m9Hm
         Fmi2yIt5Gr+OHNxNEXOtqMCx5AleufoTn9J/u8tiFjCeOUCAewaRjza5F11QFmvTy1c+
         cMoQ5xLLlPEk4kNUAzxETwZJoRvYmOllW6pv0LFZn/+qFkvbsxHGa7F/vJywVYfCCOCP
         poLA==
X-Gm-Message-State: AOAM531NwghMiYiwZJMlu5E5HOXisWflNuaCHbWkb5JHH5seaB8o4yri
        aqiQSV3/U27ws9AK50cFGwOC+Q==
X-Google-Smtp-Source: ABdhPJzkBuY/6u6BCnB+5mFHCJrUwSTIC4YYB26MteledQx57ZBrUwAq0oyYmrtqLkW4kEJHPb0gSg==
X-Received: by 2002:a17:902:f144:b0:15e:cd78:e36e with SMTP id d4-20020a170902f14400b0015ecd78e36emr4230924plb.144.1651851395901;
        Fri, 06 May 2022 08:36:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5605:d5cd:699b:1b26])
        by smtp.gmail.com with UTF8SMTPSA id e2-20020a170902e0c200b0015e8d4eb250sm1882903pla.154.2022.05.06.08.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 08:36:35 -0700 (PDT)
Date:   Fri, 6 May 2022 08:36:31 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [v15 2/6] usb: host: xhci-plat: Enable wakeup based on children
 wakeup status
Message-ID: <YnVAZSZYQvIJxOHv@google.com>
References: <1651740973-7944-1-git-send-email-quic_kriskura@quicinc.com>
 <1651740973-7944-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651740973-7944-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 05, 2022 at 02:26:09PM +0530, Krishna Kurapati wrote:
> device_wakeup_path() tells if any of the children devices needs
> wakeup. Use this hint to enable/disable wakeup of our device. This
> helps the parent device of xhci-plat (like sysdev) to retrieve
> the wakeup setting via device_wakeup_path().
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/host/xhci-plat.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 649ffd8..ad585fa 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -415,6 +415,14 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
>  	if (pm_runtime_suspended(dev))
>  		pm_runtime_resume(dev);
>  
> +	if (device_wakeup_path(dev)) {
> +		if (!device_may_wakeup(dev))
> +			device_wakeup_enable(dev);
> +	} else {
> +		if (device_may_wakeup(dev))
> +			device_wakeup_disable(dev);
> +	}

This code is not self-explantatory and deserves a comment.

Enabling/disabling wakeup for the purpose if signalling is a bit of a
hack. It might be an acceptable hack as long as it has no side effects.
However with the current implementation the wakeup state of the xHCI can
be different after resuming than it was before going to suspend:

after boot
  grep -h xhci /sys/class/wakeup/*/name
    => xhci-hcd.14.auto

after suspend w/o wakeup capable device
  grep -h xhci /sys/class/wakeup/*/name
    => no results

after suspend with wakeup capable device
  grep -h xhci /sys/class/wakeup/*/name
    => xhci-hcd.14.auto

The hack shouldn't alter the wakeup state 'persistently', i.e. you'll have
to restore it on resume, as in Pavan does in his reply to '[PATCH v14 2/7]
PM / wakeup: Add device_children_wakeup_capable()' (it needs to be done
conditionally though).
