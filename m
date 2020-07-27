Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4022FAFC
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 23:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgG0VGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 17:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0VGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 17:06:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B29C061794
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 14:06:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so3025972pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34Io1s2ohRS9fYcVvKMBQBhD9r95hojhXInNe93ltBo=;
        b=WSVfZyPTeLrfaOpfDbp1fghrlU4fQ7ISrQVlgWJOYUAvZINlRNp/MOq5BrtqHbqyyf
         uovGVPxOBa03XFLuBSubKB6o6EGew5p5MGMgiYMFtaqRL4alM+f1B8CB07Sz+f9jPbes
         y1FN3NcKNfPT/iO47JnM8TYvR+MjH7+TMRw78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=34Io1s2ohRS9fYcVvKMBQBhD9r95hojhXInNe93ltBo=;
        b=V0iGEvkWix95AAR3Aj1bYZX/xW5jAxVQ8ExsC08SrNjiD5dTK1ITRSq0GntfA2Y+Ty
         KmAXtsfVu4xUrsQMFkU9hU4zM8ZGJfwgqkjWUaKNviVVkJzu55BBjEc/rwDo+uPoaCB1
         7ixlir8wt7N2njoBxhn7U1AsXcGNpzPn+aZLDJtngUZeALyjmAVt/oR09atF5caJwvJO
         ANuyY6elubZg8ztVU9x1HKkxg7lTFpRl52TKrqeRo8Vgs6hcxuWZNBnY3qqr8p01mkEB
         xPsKhqwYP2RCI9eO5cFmvx0L6spPdEDGsQNNsSdTK00XGqMg9QgsZEvVEA+KSSNG7uRw
         Ytcg==
X-Gm-Message-State: AOAM530UjqBuh7OLXgKFOEl/c3vvLgJFHQU0gO1h5R0cYevhRic4Pe0+
        fponxQYPYJA06Ahfe9Gu0MFjwg==
X-Google-Smtp-Source: ABdhPJycSS7Qr/Sdtby+Y1JPA+w5/LNuHzbsu1UyaTDyxG5eK/rsQrZ1PHZzpkIeL9F7+tN67Ny7Rg==
X-Received: by 2002:a17:90a:c394:: with SMTP id h20mr1169984pjt.22.1595883977300;
        Mon, 27 Jul 2020 14:06:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id m6sm5020645pfk.36.2020.07.27.14.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 14:06:15 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:06:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sc7180: Increase the number of
 interconnect cells
Message-ID: <20200727210614.GJ3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-7-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723130942.28491-7-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 23, 2020 at 04:09:42PM +0300, Georgi Djakov wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> Increase the number of interconnect-cells, as now we can include
> the tag information. The consumers can specify the path tag as an
> additional argument to the endpoints.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
