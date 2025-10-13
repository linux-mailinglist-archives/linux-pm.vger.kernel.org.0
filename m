Return-Path: <linux-pm+bounces-36013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F17BD6AB7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD27188A79A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA82E283A;
	Mon, 13 Oct 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDOHLq/h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DBA2571A5
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396009; cv=none; b=ds+Mtg//bRTP8xTqJhN9Fgs4wNVnhAER+oVN6C/qiWz3kthZXQKFqc43WuNkJQBTOaz/qzSeHt3Eb+md+B34QhELjKJdMNVz2ETloHFnlukQ5vX3clR0q0Gy4SgN51RaNLM2ebiTV3YL73x5KyCr6mnMXJAUCserwMJKsZrkfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396009; c=relaxed/simple;
	bh=VxDmSLJ7Pl58cmqGN/eTKyC6uRlD8Xhn1Kk5fyLUXYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaqkS/bZ4kZiXMiGVW0uAd/2eMKgsHehwQ8ZgjE2aUmdO03lSLmr6mLsR5PndlE6ahchIs5mxqxQJWjTpoq/t23fnxgeZldbPntvtH22buAljQXuSz7BEltjb2Ptj2LvfnqY8vZ0RFVed2n+YEdwORFnAbG4ZtPx7VvS7gfUMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDOHLq/h; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4060b4b1200so3477194f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760396006; x=1761000806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VxDmSLJ7Pl58cmqGN/eTKyC6uRlD8Xhn1Kk5fyLUXYk=;
        b=TDOHLq/hSaw2994qUBI6NuSlboNI53oBq0aiCrHz12nLpQiuCr3Kez3TOvJSJn8LFm
         HYdX2WfaOlDKikibLegCJlcJ2UgdInGHIuwVLDODo1JAshszMZb8ZNzlg18l+zPAkHXD
         SfdNfygJQKTuMVgmW15C3xwehuCt/fYeRoFn9Q5sdAq0L85XV6lAmTHsForZ1Y5hGSl0
         qmk9ylSvJ7uKaLyNi6L29j3VrgCvW1zlRsi6YqRBH3Ds03YnNnKjETKiA6yUX+Ul+NCx
         wIGdPPIWCnlegIQqVFF/EA3cZOBH/prjRz9FPRuCnuJJc6FR1Jpe5uKmEE+ozIB4acET
         0lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760396006; x=1761000806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxDmSLJ7Pl58cmqGN/eTKyC6uRlD8Xhn1Kk5fyLUXYk=;
        b=iT5PanFT8wDgceT4MT8Li3MyhVBA/lI0j+Jn42+baGe8N5jarO3Lwa2VA0+kgsmc9x
         9LbAJ//ngo+YqJE9T0DCNeZQTGQRhmZQf04kp8k91gOCOq4pm0+tBWyiXx67p9PMn2q/
         a0b0y6rcX4dLL5NYsVOtO0h6kQPYMl1UrfIneOaCgdHYu0SjK0PQ4QO+owEMFPM/UpAJ
         NQchKfsMDYrhnRqWaXVFoFz+o6bXpVFIvdid8RFiDpSdorb43TiAuIyZih7iuMg/p62a
         M2J4uwORznMV6ilq5HIFKazo27ppiFUlo3mhBD3lKBwS3jOha3V+40vqq6rO3WeUr2aA
         c4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVYaAE+2GeLj+nHgDIPmNJQSPCP2S3xyNRFdGc1tQxC1kF3WE/euZnwquAkNAVH6xB/pxfEJmqR6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YylmpVdKTnBRb70Sv6eaq8QKR7bbzi/RtAY0x7uhU5Cnud9VRc+
	CfgTLpDPz1pmPz2IJL6ewV8yuYvf6yg15zbAM0SSdXtFBLQ+KvIzHUtvN8yzsLEOYNbeGECLQtx
	9zAVSYjWmTIzMwV7BzkrdRgEGFWVB3KH+rT/6NlnE
X-Gm-Gg: ASbGncuJLRtZrtTJ9kYpi7XFeTpoHj1wozPlUUCTKo2XJZj075c4nmkCBAWPlx8MQci
	TRArGotELIsXltMtKx0o+Do43gS3pIDOvyDkZdx+6Gp5Lv2XiJXCuqSLEDkrlCrNS1cpRsx3a23
	0mUk6UtivD6yao5Ez6wlAUMPMwTnhOHsDkEOz2zUqqYRZQO/K7SmoOPaCialsHhh7155NcVdY33
	5DkIKZdN7aR1dH3+xkAf4mCJcQDQFcxBrtDVlv7ExsbSWP2gRL/xnG47NPJEfw=
X-Google-Smtp-Source: AGHT+IHN0t3NmIlHBzBN76m1atkXs712mA3WKLgcMNSupWFwJZ3i0jdFLSUHLWMjbly990ZrauvZiG0fi3+9cSLBVUQ=
X-Received: by 2002:a05:6000:2f82:b0:425:825d:2c64 with SMTP id
 ffacd0b85a97d-4266e7d6472mr16363020f8f.17.1760396005998; Mon, 13 Oct 2025
 15:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <92c821fb-537a-40e6-98fc-616941b57778@panix.com>
In-Reply-To: <92c821fb-537a-40e6-98fc-616941b57778@panix.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 15:53:13 -0700
X-Gm-Features: AS18NWB5frOXzr6oF_XfKeFC8F4rRq6IsJiUPIJr2IgROQ85_BdLxUbQKV6WZZ0
Message-ID: <CAMFSARf8--QW9otZDFGE4yr9i_WjYuwehJ0cV3ioD8KZFzjXaw@mail.gmail.com>
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
To: Kenneth Crudup <kenny@panix.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kenneth,
You are correct that adding POWER_SUPPLY_USB_TYPE_PD_DRP in
ucsi_register_port_psy() is missing here. I would have expected that
adding it resolves the issue. I'll take a closer look, thanks for
raising this.

