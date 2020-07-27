Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D6822FA60
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0UvY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 16:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgG0UvU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 16:51:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A26CC0619D4
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:51:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so3004467pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bjL1e5uiS5p+oa9NfwO4lDZAbGheLK7Om3uvKuKgPGU=;
        b=GCcyJqDtRNEb60SBLpWXIGlNdJmFit1eYgHB+EDztoLvkbNic6roZHuERLgxCRidt5
         Fplk1HBV8l+LPzS6+DED2eo0Z5z1tnrCkEfQfeU9nIaJRvLs/oMF+SPA47ybbGQ8mokD
         K7bfSpmm4SoGAWQLl+h1Jd9j8Jxn2tahW0ytg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bjL1e5uiS5p+oa9NfwO4lDZAbGheLK7Om3uvKuKgPGU=;
        b=ubmNUfaFhTBrK3XqgJFun4xwYeBOPR6175E/8AUa/gxRpUSxIByFLhmN7ealHnSdgw
         Dro6+yQrwG7SGf1E0PCpOtEutrP27qLCas4VZex+TRuuyATA5OzRgLozkUeOcXsmozfZ
         EJtfIumxcnxeFGVOuIBZBx/IUUvx4qbjtN//DBK+/VT0JnIeKsP0AQJlP4rzKRefuoQh
         zBeseafQN1Urzu1b8N9JUQBPTw/F31RaQQq6yzx34J7P3GsAWPnrIzJyS3dNu63b0mmt
         9iIknN+tmuw1F7CjgUkPVDLZ2kpqxJvj6OAGHOQLX/ffP4Ve7098W+lUSu69b2/ptY9V
         nvnA==
X-Gm-Message-State: AOAM531JFOp79W9makB0BbGFDg+LWjzhj/ixaBUo9Y2PfOUt0CuJOZO3
        iIsup/+YVtXYlMfncLOJT7UePA==
X-Google-Smtp-Source: ABdhPJzJTFDP4pfmQbG2IcY6+g7QazsrNBlZaeZb5C2taHPiz/0GqOjF9ag32KJXzUF6U7lBephsQw==
X-Received: by 2002:a17:90a:a68:: with SMTP id o95mr1119459pjo.64.1595883079734;
        Mon, 27 Jul 2020 13:51:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id w70sm8621216pfc.98.2020.07.27.13.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:51:18 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:51:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] interconnect: qcom: sdm845: Replace xlate with
 xlate_extended
Message-ID: <20200727205117.GG3191083@google.com>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-4-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200723130942.28491-4-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 23, 2020 at 04:09:39PM +0300, Georgi Djakov wrote:
> Use the qcom_icc_xlate_extended() in order to parse tags, that are
> specified as an additional arguments to the path endpoints in DT.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
