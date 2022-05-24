Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6872533356
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbiEXWMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiEXWMm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 18:12:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E35DE4C
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 15:12:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so2825208pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u8CD/oP1dRwpstmWmx4PFVLSC5EU/3DeFLUGGUSnZB0=;
        b=jLj+T7+1Hfq7NpU3hWA1j/dqSqZGIxKK2h7MRyu+Xdp3NbnM6i3JiEOdS9voRiJYBK
         dI57J846prVWNRcRGFP0bCLmKv6S5ZV+Szzn8qS9yQuBtkat0pvdelOHYF8RvpWlmCaP
         ZWJwz+M+SNRKzqA5LAQlIr9lRe+1YYbHfy1+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8CD/oP1dRwpstmWmx4PFVLSC5EU/3DeFLUGGUSnZB0=;
        b=jBWdKmFAZu/LpxH9oECXjd+gDxbeAPL/2qOBB4p06HeVpwMDl6JOnYXbbiNbxMccEi
         4j2JS0QNaeErjnZYXQjeO8Jf0VjwMNSVjjg+wS7WoG6gxNySRHzdBxR417Oa7P13qPuZ
         1G4f3nJOyL7Zsbe8GjNNDB3rbgn8LHa4sONozKnfTejYS4Ku9MX+gpqpPSMUov0idD8E
         iig7WES1DFXvXwqjRB0rvkqT9302k3mnjOM1gsRiIvd8LIIRSuHTU3BS84aBukA47a3T
         8urmcSiNOHCKsEzvlo0jgbcYxYDTfOy8ngEXs0nQN5RCC5jS3ioMle9J78OF57ucxVV7
         aKcg==
X-Gm-Message-State: AOAM5304sTrMHqHWuHT9PUD3NT2IWETOlEgfAlb8YX2+WZYvkcMenUSi
        Qeapdr+Nyd+5+3vN8hSNN7+5tQ==
X-Google-Smtp-Source: ABdhPJylZSxgbbxQTXu74nYTjl6enFdemPoZ3wjsjlyZ3DSDQI0D9YnLX2MmUg34d1UzfDnnWFjv9A==
X-Received: by 2002:a17:90b:4a90:b0:1df:e3af:c6ad with SMTP id lp16-20020a17090b4a9000b001dfe3afc6admr6734751pjb.41.1653430360054;
        Tue, 24 May 2022 15:12:40 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4d83:f549:9abd:427])
        by smtp.gmail.com with UTF8SMTPSA id ji3-20020a170903324300b0015e8d4eb25csm1831169plb.166.2022.05.24.15.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:12:39 -0700 (PDT)
Date:   Tue, 24 May 2022 15:12:38 -0700
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
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [PATCH v17 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <Yo1YVi2/k1Iu1ovl@google.com>
References: <1653387228-28110-1-git-send-email-quic_kriskura@quicinc.com>
 <1653387228-28110-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1653387228-28110-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 24, 2022 at 03:43:45PM +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Check wakeup-source property for dwc3 core node to set the
> wakeup capability. Drop the device_init_wakeup call from
> runtime suspend and resume.
> 
> If the dwc3 is wakeup capable, don't power down the USB PHY(s).
> The glue drivers are expected to take care of configuring the
> additional wakeup settings if needed based on the dwc3 wakeup
> capability status. In some SOC designs, powering off the PHY is
> resulting in higher leakage, so this patch save power on such boards.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
