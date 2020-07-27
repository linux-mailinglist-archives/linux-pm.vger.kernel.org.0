Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49022FABE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgG0Uzs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 16:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgG0Uzr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 16:55:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECBC0619D4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:55:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so10645315pgf.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bhP8c3ORdPWDlqnnbGuCZRHV46MZaJIZrpgZrFhGf0A=;
        b=FTa08JumHKpL7dCKC6F3Y/47u+bsnLr2xoLj/mrKwMm9jY+pMPtRfLqaiYH5ajOiuy
         gwazm9DFfePxGyl1LYAaSGP02ptms9TKzvb23nHDTO2FYNuIU9JcTYHTlwu84rQ516tL
         nTujTvdWrvTobCmmr/ve2s3jKy/eDqOyoG5Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bhP8c3ORdPWDlqnnbGuCZRHV46MZaJIZrpgZrFhGf0A=;
        b=MDF8XIfmvoYuOuhMZ7GiPMsXVhHvarV+brTmri01SrWfYvY3vPKD7OMf8rB0hHdG5P
         WGTkn4U4v+gmre91QUtLBF01UzmE++KOqOY1Zi94pWz0TCpdTK45diO5QSdcp9vrXqWr
         bn/RL2Y9vclZxOvGmMfnXeLN+W/yBLR711QOXynELzwsqauzVKiO4YcD54x3ysbXGRGP
         linm9UW2WUAfvektTPYyOPsLG+Lf+pAYFb0JtVcvn+sOPSegXdXp7YxOgNYyhzlPMD7F
         j0Bwi9X3JqEMhIxF4F19FBG+QfSD2sH9+nD/aYy7W7+2CBeGMouL/0+lLgcSJQDnunaD
         4hbw==
X-Gm-Message-State: AOAM5337H4Zme4p7gai7lqSBZdrqtAOtYFpwxoLIrYi95DnXnLxoDGxc
        t9WO2f6o4qKvSOwTiG/SIaLnug==
X-Google-Smtp-Source: ABdhPJxjpKz+El+vxYGRCL/Ty0XO15gWn2h9AfLlj9O3/ZH0J4sph2IftFtarPwxqF/aRzxx/DSE8Q==
X-Received: by 2002:aa7:848b:: with SMTP id u11mr21353847pfn.72.1595883347093;
        Mon, 27 Jul 2020 13:55:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id d9sm16200235pgv.45.2020.07.27.13.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:55:46 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:55:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sdm845: Increase the number of
 interconnect cells
Message-ID: <20200727205545.GH3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-5-georgi.djakov@linaro.org>
 <3c8c4aae7697d9d5a052b9dfd1ea0cf4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c8c4aae7697d9d5a052b9dfd1ea0cf4@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 27, 2020 at 04:28:35PM +0530, Sibi Sankar wrote:
> On 2020-07-23 18:39, Georgi Djakov wrote:
> > Increase the number of interconnect-cells, as now we can include
> > the tag information. The consumers can specify the path tag as an
> > additional argument to the endpoints.
> 
> Tested-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> 
> https://patchwork.kernel.org/patch/11655409/
> I'll replace the tag ids with the
> macros once ^^ lands.

Great, I was going to ask about that :)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
