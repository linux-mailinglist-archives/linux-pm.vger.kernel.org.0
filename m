Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C600122FAD4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgG0U65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgG0U65 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 16:58:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAFC0619D4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:58:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e22so3195740pjt.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1oR/0P9ErtpTgrX+m0OBVrR3VYxPvi53ReAdjDAOr4Y=;
        b=I5dX71/Uvcfwk/jblm750/2EXt9yjhsPtSEdC4N4lQ/AO2FGB8gfWH/WsjvuuSQOyj
         ONY5pB87KzLdpaf2iZKf6HtgyagXcsssjLA0pBtIbfYXso5X7qhilKimVkhh0S66fKIy
         UdZRRQbO/XKIGmFIbA50WIhCZmfQ+15/zHM9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1oR/0P9ErtpTgrX+m0OBVrR3VYxPvi53ReAdjDAOr4Y=;
        b=D4rOZ/m4ri8O5lKnE/uvmU0RdZDUIukfo3D4AINS36gu6w1bZImYGbGVBnXOzLoSmv
         jiZh0zFk6NN1Eoms9FOaePQTh0oMjNbbcAj0YfjmMrVu5QZZIdecgVC4i1xtiC7y2weK
         6A1wlmcYEd3cvMjXK4xQ7JVVqy/YpmJ3MEVCCLL1536GrzNUnYbyhPENU2H64T0QfSRP
         1V6r6WiFSKwqqe8Ys6s3NoDw5h34sN1luWjkxf8kd5gfYIrnLNnqFqqhSLqtGDfn3oAZ
         +w8gl2Z4fIJYHN6IbeCxSY0AEtfav/xQ8XHXxKuocy+LQ2OoM5T6MWMapTAi3fH1klpf
         3y/g==
X-Gm-Message-State: AOAM533DM6Vk5GuXWUI5CtSMYvPG5seHhKs69x6hcfVSU2ROxpDDKzfz
        YJdl+wM2SXzK6KrnzRileGUb+A==
X-Google-Smtp-Source: ABdhPJwNPDS+cc+l5C6Fk46mxdaDL9PclHliTxJP5rQfP6oKuQNDrzGsoCx2t1y2JMkjPqG1jMFPKw==
X-Received: by 2002:a17:902:7485:: with SMTP id h5mr7030550pll.282.1595883536582;
        Mon, 27 Jul 2020 13:58:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id g8sm15819746pgr.70.2020.07.27.13.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:58:55 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:58:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] interconnect: qcom: sc7180: Replace xlate with
 xlate_extended
Message-ID: <20200727205855.GI3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-6-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723130942.28491-6-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 23, 2020 at 04:09:41PM +0300, Georgi Djakov wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> Use the qcom_icc_xlate_extended() in order to parse tags, that are
> specified as an additional arguments to the path endpoints in DT.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
